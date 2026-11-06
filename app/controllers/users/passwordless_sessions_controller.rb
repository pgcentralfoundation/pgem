class Users::PasswordlessSessionsController < Devise::Passwordless::SessionsController
  def create
    self.resource = resource_class.find_by(email: session_params[:email])

    if resource && resource.respond_to?(:confirmed?) && !resource.confirmed?
      flash[:warning] = "Your account is unconfirmed. Please check your email for confirmation instructions."
      redirect_to(after_magic_link_sent_path_for(resource), status: devise_redirect_status) and return
    end

    super
  end

  private

  def session_params
    params.expect(resource_name => [:email])
  end
end