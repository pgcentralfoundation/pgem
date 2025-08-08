class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :check_public_profile, only: :show
  layout 'userprofile', only: :show

  # GET /users/1
  def show
    @events = @user.events.where(state: :confirmed)
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    @user.assign_attributes(user_params)
    @user.current_sign_in_ip = request.ip
    result = UserClassifier.instance.check @user
    if result[:score] >= 0.4
      Rails.logger.warn "[DENY] profile update from potential spammer: #{request.params}, test results: #{result}"
      render plain: 'Service Unavailable', status: 503 and return
    end

    if @user.update(user_params)
      if params[:remove_avatar]
        @user.remove_avatar!
        @user.save
      end
      redirect_to @user, notice: 'User was successfully updated.'
    else
      flash.now[:error] = "An error prohibited your Profile from being saved: #{@user.errors.full_messages.join('. ')}."
      render :edit
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :biography, :nickname,
        :nickname_type, :affiliation, :avatar, :remove_avatar, :title, :mobile,
        :country, :state, :city)
    end

    def check_public_profile
      return if current_user && current_user.is_admin
      if current_user != @user
        unless @user.roles.any? || @user.registrations.any? || @user.events.any?
          Rails.logger.warn "[DENY] access to dummy profile: #{@user.friendly_id}"
          not_found
        end
      end
    end
end
