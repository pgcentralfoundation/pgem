module Admin
  class EventsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :program, through: :conference, singleton: true
    load_and_authorize_resource :event, through: :program
    load_and_authorize_resource :events_registration, only: :toggle_attendance
    # load_and_authorize_resource :user, only: :new

    before_action :get_event, except: [:index, :create, :new, :bulk_state_change]

    # FIXME: The timezome should only be applied on output, otherwise
    # you get lost in timezone conversions...
    # around_filter :set_timezone_for_this_request

    def set_timezone_for_this_request(&block)
      Time.use_zone(@conference.timezone, &block)
    end

    def index
      @tag_name = params[:tag]
      if @tag_name
        @events = @program.events.tagged_with(@tag_name)
      else
        @events = @program.events
      end

      @track_name = params[:track]
      if @track_name
        @events = @events.joins(:track).where(tracks: {name: @track_name})
      end

      @type = params[:type]
      if @type
        @events = @events.joins(:event_type).where(event_types: {title: @type})
      end

      @difficulty = params[:difficulty]
      if @difficulty
        @events = @events.joins(:difficulty_level).where(difficulty_levels: {title: @difficulty})
      end

      @state = params[:state]
      if @state
        @events = @events.where(state: @state)
      end

      @tracks = @program.tracks
      @difficulty_levels = @program.difficulty_levels
      @event_types = @program.event_types
      @tracks_distribution_confirmed = @conference.tracks_distribution(:confirmed)
      @event_distribution = @conference.event_distribution
      @scheduled_event_distribution = @conference.scheduled_event_distribution
      @file_name = "events_for_#{@conference.short_title}"
      @event_export_option = params[:event_export_option]
      @tickets = @conference.tickets
      @tags = Event.tag_counts_on(:tags)

      respond_to do |format|
        format.html
        # Explicity call #to_json to avoid the use of EventSerializer
        format.json { render json: Event.where(state: :confirmed, program: @program).to_json }
        format.xlsx do
          response.headers['Content-Disposition'] = "attachment; filename=\"#{@file_name}.xlsx\""
          render 'events'
        end
        format.pdf {render 'events'}
        format.csv do
          response.headers['Content-Disposition'] = "attachment; filename=\"#{@file_name}.csv\""
          render 'events'
        end
      end
    end

    def show
      @tracks = @program.tracks
      @event_types = @program.event_types
      @comments = @event.root_comments
      @comment_count = @event.comment_threads.count
      @ratings = @event.votes.includes(:user)
      @difficulty_levels = @program.difficulty_levels
      @tickets = @conference.tickets
      @attendees = @event.attendees
      @versions = @event.versions |
       PaperTrail::Version.where(item_type: 'Commercial').where_object(commercialable_id: @event.id, commercialable_type: 'Event') |
       PaperTrail::Version.where(item_type: 'Commercial').where_object_changes(commercialable_id: @event.id, commercialable_type: 'Event')
    end

    def edit
      @event_types = @program.event_types
      @tracks = Track.all
      @comments = @event.root_comments
      @comment_count = @event.comment_threads.count
      @user = @event.submitter
      @users = User.speakers_only.order(:name)
      @url = admin_conference_program_event_path(@conference.short_title, @event)
      @languages = @program.languages_list
    end

    def comment
      comment = Comment.new(comment_params)
      comment.commentable = @event
      comment.user_id = current_user.id
      comment.save!
      unless params[:parent].nil?
        comment.move_to_child_of(params[:parent])
      end

      redirect_to admin_conference_program_event_path(@conference.short_title, @event)
    end


    def attendees
      @file_name = "attendees_for_#{@event.friendly_id}"
      @attendees = @event.attendees.order(:first_name, :last_name)
      respond_to do |format|
        # format.html
        format.xlsx do
          response.headers['Content-Disposition'] = "attachment; filename=\"#{@file_name}.xlsx\""
          render 'attendees'
        end
        format.pdf {render 'attendees'}
        format.csv do
          response.headers['Content-Disposition'] = "attachment; filename=\"#{@file_name}.csv\""
          render 'attendees'
        end
      end
    end

    def update
      # @event.validate_owners = true
      @users = User.all.order(:name)
      if @event.update_attributes(event_params)

        if request.xhr?
          render js: 'index'
        else
          flash[:notice] = "Successfully updated event with ID #{@event.id}."
          redirect_back_or_to(admin_conference_program_event_path(@conference.short_title, @event))
        end
      else
        @url = admin_conference_program_event_path(@conference.short_title, @event)
        flash.now[:error] = 'Update not successful. ' + @event.errors.full_messages.to_sentence
        render :edit
      end
    end

    def create
      @url = admin_conference_program_events_path(@conference.short_title, @event)
      @users = User.speakers_only.order(:name)
      @languages = @program.languages_list
      @event.submitter = current_user

      if @event.event_type.internal_event?
        @event.update_state(:accept, 'Event accepted!', false, false, false)
        @event.update_state(:confirm, 'Event confirmed!')
      end

      if @event.save
        ahoy.track 'Event submission', title: 'New submission'
        redirect_to admin_conference_program_events_path(@conference.short_title), notice: 'Event was successfully submitted.'
      else
        flash.now[:error] = "Could not submit proposal: #{@event.errors.full_messages.join(', ')}"
        render action: 'new'
      end
    end

    def new
      @url = admin_conference_program_events_path(@conference.short_title, @event)
      @languages = @program.languages_list
      @users = User.speakers_only.order(:name)
    end

    def accept
      send_mail = @event.program.conference.email_settings.send_on_accepted
      subject = @event.program.conference.email_settings.accepted_subject.blank?
      update_state(:accept, 'Event accepted!', true, subject, send_mail)
    end

    def accept_and_confirm
      send_mail = @event.program.conference.email_settings.send_on_accepted
      subject = @event.program.conference.email_settings.accepted_subject.blank?
      @event.update_state(:accept, true, subject, send_mail, params[:send_mail].blank?)
      update_state(:confirm, 'Event accepted and confirmed!')
    end

    def bulk_state_change
      @events = Event.find(params[:event_ids])
      @transition = params[:state].to_sym
      @notice = 'Events updated'
      @errors = []
      @events.each do |event|
        begin
          event.send(@transition, send_mail: params[:send_mail].blank?)
          event.save!
        rescue Transitions::InvalidTransition => e
          @errors.push "update state failed: #{e.message}"
        rescue ActiveRecord::RecordInvalid => e
          @errors.push "event #{event.id}: #{e.message}"
        end
      end

      @notice += ', there were some errors' unless @errors.blank?
      flash[:notice] = @notice if @errors.size != @events.size
      flash[:error] = 'Failed to update: ' + @errors.join('; ') unless @errors.blank?

      if @errors.blank?
        # redirect to events admin index to reset any set checkboxes
        render js: "window.location = '#{admin_conference_program_events_path(conference_id: @conference.short_title)}'"
      else
        # reload the current page, this keeps previous selections
        render js: "window.location.reload()"
      end
    end

    def confirm
      update_state(:confirm, 'Event confirmed!')
    end

    def cancel
      update_state(:cancel, 'Event canceled!')
    end

    def reject
      send_mail = @event.program.conference.email_settings.send_on_rejected
      subject = @event.program.conference.email_settings.rejected_subject.blank?
      update_state(:reject, 'Event rejected!', true, subject, send_mail)
    end

    def restart
      update_state(:restart, 'Review started!')
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
        format.html { redirect_to admin_conference_program_event_path(@conference.short_title, @event) }
        format.js
      end
    end

    def registrations
      @event_registrations = @event.events_registrations
    end

    def toggle_attendance
      @events_registration.attended = !@events_registration.attended

      if @events_registration.save
        head :ok
      else
        head :unprocessable_entity
      end
    end

    private

    def event_params
      params.require(:event).permit(
                                    # Set also in proposals controller
                                    :tag_list, :title, :subtitle, :event_type_id, :abstract, :description, :require_registration, :difficulty_level_id, :document,
                                    # Set only in admin/events controller
                                    :track_id, :state, :language, :is_highlight, :max_attendees, :ticket_id,
                                    # Not used anymore?
                                    :proposal_additional_speakers, :user, :users_attributes,
                                    :speaker_ids => []
                                     )
    end

    def comment_params
      params.require(:comment).permit(:commentable, :body, :user_id)
    end

    def get_event
      @event = @conference.program.events.find(params[:id])
      unless @event
        redirect_to admin_conference_program_events_path(conference_id: @conference.short_title),
                    error: 'Error! Could not find event!'
        return
      end
      @event
    end

    def update_state(transition, notice, mail = false, subject = false, send_mail = false)
      alert = @event.update_state(transition, mail, subject, send_mail, params[:send_mail].blank?)

      if alert.blank?
        flash[:notice] = notice
        redirect_back_or_to(admin_conference_program_events_path(conference_id: @conference.short_title)) && return
      else
        flash[:error] = alert
        return redirect_back_or_to(admin_conference_program_events_path(conference_id: @conference.short_title)) && return
      end
    end
  end
end
