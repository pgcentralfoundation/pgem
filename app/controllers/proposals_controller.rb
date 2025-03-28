class ProposalsController < ApplicationController
  before_action :load_invitation, only: :accept_invitation
  before_action :authenticate_user!, except: [:show, :new, :create]
  load_resource :conference, find_by: :short_title
  load_resource :program, through: :conference, singleton: true, except: :my_proposals
  load_and_authorize_resource :event, parent: false, through: :program, except: :my_proposals
  # We authorize manually in these actions
  skip_authorize_resource :event, only: [:confirm, :restart, :withdraw, :comment, :vote, :invite, :accept_invitation]
  skip_authorization_check :only => [:comment, :vote, :my_proposals, :invite, :accept_invitation]

  def index
    @event = @program.events.new
    @event.event_users.new(user: current_user, event_role: 'submitter')
    @events = current_user.proposals(@conference)
    @participated_events = current_user.participated_events(@conference) - @events
  end

  def my_proposals
    @events = current_user.proposals
    @participated_events = current_user.participated_events - @events
    render action: 'index'
  end

  def show
    @event_schedule = @event.event_schedules.find_by(schedule_id: @program.selected_schedule_id)
    @speakers_ordered = @event.speakers_ordered
    @comments = []
    @comments = @event.root_comments.find_comments_by_user(@current_user) if @current_user
    @ratings = @event.votes.includes(:user)

    # redirect user to the slugged url
    if request.path != conference_program_proposal_path(@conference.short_title, @event)
      return redirect_to conference_program_proposal_path(@conference.short_title, @event), status: :moved_permanently
    end
  end

  def new
    @user = User.new
    @url = conference_program_proposals_path(@conference.short_title)
    @languages = @program.languages_list
  end

  def edit
    @url = conference_program_proposal_path(@conference.short_title, params[:id])
    @users = User.speakers_only.order(:name)
    @languages = @program.languages_list
  end

  def create
    @url = conference_program_proposals_path(@conference.short_title)
    # We allow proposal submission and sign up on same page.
    # If user is not signed in then first create new user and then sign them in
    unless current_user
      @user = User.new(user_params)

      unless verify_recaptcha(model: @user)
        flash.now[:error] = "Captcha verification failed"
        render action: 'new'
        return
      end

      if @conference.use_pg_flow
        @user.username = @user.email
      end

      authorize! :create, @user
      if @user.save
        sign_in(@user)
      else
        flash.now[:error] = "Could not save user: #{@user.errors.full_messages.join(', ')}"
        render action: 'new'
        return
      end
    end

    # User which creates the proposal is both `submitter` and `speaker` of proposal
    # by default.
    @event.speakers = [current_user]
    @event.submitter = current_user
    if @event.save
      ahoy.track 'Event submission', title: 'New submission'
      if @event.speakers_pending
        redirect_to edit_conference_program_proposal_path(@conference.short_title, @event), notice: 'Proposal was successfully submitted but there are no speakers yet. You can send some speaker invitations below.'
      else
        redirect_to conference_program_proposals_path(@conference.short_title), notice: 'Proposal was successfully submitted.'
      end
    else
      flash.now[:error] = "Could not submit proposal: #{@event.errors.full_messages.join(', ')}"
      render action: 'new'
    end
  end

  def update
    @url = conference_program_proposal_path(@conference.short_title, params[:id])
    @users = User.all.order(:name)

    if @event.update(event_params)
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  notice: 'Proposal was successfully updated.'
    else
      flash.now[:error] = "Could not update proposal: #{@event.errors.full_messages.join(', ')}"
      render action: 'edit'
    end
  end

  def comment
    comment = Comment.new(comment_params)
    comment.commentable = @event
    comment.user_id = current_user.id
    comment.save!
    unless params[:parent].nil?
      comment.move_to_child_of(params[:parent])
    end

    redirect_to conference_program_proposal_path(@conference.short_title, @event)
  end

  def vote
    @ratings = @event.votes.includes(:user)
    if (votes = current_user.votes.find_by_event_id(Event.find(params[:id]).id))
      votes.update_attributes(rating: params[:rating])
    else
      @myvote = @event.votes.build
      @myvote.user = current_user
      @myvote.rating = params[:rating]
      @myvote.save
    end

    respond_to do |format|
      format.html { redirect_to conference_program_proposal_path(@conference.short_title, @event) }
      format.js
    end
  end

  def withdraw
    authorize! :update, @event
    @url = conference_program_proposal_path(@conference.short_title, params[:id])

    begin
      @event.withdraw
    rescue Transitions::InvalidTransition
      redirect_to :back, error: "Event can't be withdrawn"
      return
    end

    if @event.save
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  notice: 'Proposal was successfully withdrawn.'
    else
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  error: "Could not withdraw proposal: #{@event.errors.full_messages.join(', ')}"
    end
  end

  def confirm
    authorize! :update, @event
    @url = conference_program_proposal_path(@conference.short_title, params[:id])

    begin
      @event.confirm
    rescue Transitions::InvalidTransition
      redirect_to :back, error: "Event can't be confirmed"
      return
    end

    if @event.save
      if @conference.user_registered?(current_user)
        redirect_to conference_program_proposals_path(@conference.short_title),
                    notice: 'The proposal was confirmed.'
      else
        redirect_to conference_buytickets_path(conference_id: @conference.short_title),
                    alert: 'The proposal was confirmed. Please register to attend the conference.'
      end
    else
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  error: "Could not confirm proposal: #{@event.errors.full_messages.join(', ')}"
    end
  end

  def restart
    authorize! :update, @event
    @url = conference_program_proposal_path(@conference.short_title, params[:id])

    begin
      @event.restart
    rescue Transitions::InvalidTransition
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  error: "The proposal can't be re-submitted."
      return
    end

    if @event.save
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  notice: "The proposal was re-submitted. The #{@conference.short_title} organizers will review it again."
    else
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
                  error: "Could not re-submit proposal: #{@event.errors.full_messages.join(', ')}"
    end
  end

  def invite
    @invitation = @event.speaker_invitations.find_or_initialize_by(invitation_params)
    authorize! :create, @invitation
    if not @invitation.new_record?
      @invitation.send_notification
      flash[:notice] = "Invitation already existed, a new invitation email has been sent to #{@invitation.email}"
      render js: "window.location = window.location" and return
    end

    if @invitation.save
      flash[:notice] = "Speaker invitation has been sent to #{@invitation.email}"
    else
      flash[:error] = "Failed to invite #{@invitation.email}: #{@invitation.errors.full_messages.join(', ')}"
    end
    # yeah, that' weird but it works. the idea here is to reload the current screen AND reset the email in the invitation form
    render js: "window.location = window.location"
  end

  def accept_invitation
    session.delete(:pending_invitation_url)
    if @invitation.accept
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
        notice: "You have been added as a speaker to #{@invitation.event.title}. Thank you!"
    else
      redirect_to conference_program_proposals_path(conference_id: @conference.short_title),
        error: "Failed to accept invitation: #{@invitation.errors.full_messages.join(', ')}"
    end
  end

  def registrations; end

  def authenticate_user!
    redirect_to(new_user_registration_path) unless user_signed_in?
  end

  private

  def event_params
    params.require(:event).permit(:event_type_id, :track_id, :difficulty_level_id,
                                  :title, :subtitle, :abstract, :description, :document,
                                  :require_registration, :max_attendees, :language, :speakers_pending,
                                  :speaker_ids => []
                                  )
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :affiliation, :mobile,
                                 :email, :password, :password_confirmation, :username)
  end

  def comment_params
    params.require(:comment).permit(:commentable, :body, :user_id)
  end

  def load_invitation
    @invitation = SpeakerInvitation.find_by_token(params[:token])
    return redirect_to root_path, alert: 'not found' unless @invitation

    unless current_user
      session[:pending_invitation_url] = request.original_url
      invitee = User.find_by(email: @invitation.email)
      if invitee.present?
        redirect_to new_user_session_path, alert: 'Please login to accept your invitation.'
      else
        redirect_to new_user_registration_path, alert: 'Please register first.'
      end
    end
  end

end
