class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  prepend_before_action :check_captcha, only: [:create, :update]
  prepend_before_action :check_geoip, only: [:create, :update]

  def edit
    @openids = Openid.where(user_id: current_user.id).order(:provider)
    super
  end

  def update
    @openids = Openid.where(user_id: current_user.id).order(:provider)
    super
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end

  def after_sign_up_path_for(resource)
    if session[:previous_url].blank?
      edit_user_registration_path(resource)
    else
      session[:previous_url] || new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.
          permit(:email, :password, :password_confirmation, :current_password, :username)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.
          permit(:first_name, :last_name, :title, :affiliation, :mobile, :email, :password, :password_confirmation, :name, :username)
    end
  end
end

private
  def check_captcha
      unless verify_recaptcha
          self.resource = resource_class.new sign_up_params
          resource.validate
          respond_with_navigational(resource) { render :new }
      end
  end

  BLOCKED_COUNTRY_CODES = %w(VN PK BD RU BY DZ VE UA MN)

  def check_geoip
    country_code = request.location.country_code
    if BLOCKED_COUNTRY_CODES.include? country_code
      Rails.logger.warn "[DENY] registration from #{country_code}: #{request.params}"
      redirect_to root_path
    end
  end