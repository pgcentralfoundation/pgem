module SpinaCustomAuth
  extend ActiveSupport::Concern

  included do
    helper_method :current_spina_user, :logged_in?, :logout_path
  end

  def current_spina_user
    return nil unless user_signed_in?
    
    # .becomes(Spina::User) remaps PGEM user model to customized Spina variant
    @current_spina_user ||= current_user.becomes(Spina::User)
  end

  def logged_in?
    # Check if a user is signed in AND they are an admin
    current_spina_user&.admin?
  end

  def logout_path
    main_app.destroy_user_session_path
  end

  private

  def authenticate
    unless logged_in?
      redirect_to main_app.new_user_session_path, alert: "Admin access required."
    end
  end
end