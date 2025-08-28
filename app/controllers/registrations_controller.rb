class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  prepend_before_action :check_captcha, only: [:create, :update]
  prepend_before_action :check_geoip, only: [:create, :update]
  prepend_before_action :check_stopforumspam, only: [:create] 

  def edit
    @openids = Openid.where(user_id: current_user.id).order(:provider)
    super
  end

  def update
    @openids = Openid.where(user_id: current_user.id).order(:provider)
    super
  end

  def create
    u = build_resource sign_up_params
    u.current_sign_in_ip = request.ip
    result = UserClassifier.instance.check u
    if result[:score] >= 0.3
      Rails.logger.warn "[DENY] registration from potential spammer: #{request.params}, test results: #{result}"
      render plain: 'Service Unavailable', status: 503 and return
    end
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

  def check_stopforumspam
    Rails.logger.info "Querying StopForumSpam: #{request.params}"
    begin
      ip_address = request.remote_ip
      email = request.params['user']['email']
      uri = URI.parse("https://api.stopforumspam.org/api?f=json&ip=#{ip_address}&email=#{email}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 2
      http.read_timeout = 2

      req = Net::HTTP::Get.new(uri.request_uri)
      response_raw = http.request(req)
      response = JSON.parse(response_raw.body)
      if response['success']
        if response['ip']['appears'] != 0 || response['email']['appears'] != 0
          Rails.logger.warn "[DENY] registration because of failed stopforumspam check: #{response}"
          redirect_to root_path
        end
      end
    rescue Net::OpenTimeout
      Rails.logger.warn "StopForumSpam request timed out"
    rescue StandardError => e
      Rails.logger.warn "Couldn't validate against StopForumSpam: + #{e.message}"
    end
  end