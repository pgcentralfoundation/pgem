module Admin
  class PoliciesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, except: [:new, :create]

    def index
      globals = Policy.where(global: true)
      @policies = globals | Policy.where(conference_id: @conference.id) | @conference.policies
    end

    def show
    end

    def new
      @policy = Policy.new(conference_id: @conference.id)
    end

    def create
      @policy = @conference.policies.new(policy_params)
      @policy.conference_id = @conference.id unless @policy.global?
      authorize! :create, @policy

      respond_to do |format|
        if @conference.save
          format.html { redirect_to admin_conference_policies_path, notice: 'Policy was successfully created.' }
        else
          format.html { redirect_to admin_conference_policies_path, error: "Oops, couldn't save Policy. #{@policy.errors.full_messages.join('. ')}" }
        end
      end
    end

    # GET policies/1/edit
    def edit
      if @policy.global
        flash[:warning] = 'Warning: You are trying to edit a global policy. Your updates will affect all conferences using it.'
      end
    end

    # PUT policies/1
    def update
      if @policy.update(policy_params)
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          notice: "Policy '#{@policy.title}' for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          error: "Update of policies for #{@conference.short_title} failed. #{@policy.errors.full_messages.join('. ')}"
      end
    end

    # Update policies used for the conference
    def update_conference
      authorize! :update, Policy.new(conference_id: @conference.id)
      if @conference.update(conference_params)
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          notice: "Policies for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          error: "Update of policies for #{@conference.short_title} failed."
      end
    end

    # DELETE policies/1
    def destroy
      if @policy.destroy
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          notice: "Deleted policy: #{@policy.title}"
      else
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title),
          error: "Policy couldn't be deleted. #{@track.errors.full_messages.join('. ')}."
      end
    end

    private

    def policy_params
      params.require(:policy).permit(:title, :global, :description, :conference_id)
    end

    def conference_params
      params.require(:conference).permit(policy_ids: [])
    end
  end
end
