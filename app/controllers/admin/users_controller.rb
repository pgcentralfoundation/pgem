module Admin
  class UsersController < Admin::BaseController
    load_and_authorize_resource

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.skip_confirmation!
      if @user.save
        redirect_to admin_users_path, notice: 'User successfully created.'
      else
        flash.now[:error] = "Creating User` failed: #{@user.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def index
      respond_to do |format|
        format.html
        format.json {
          render json: UserDatatable.new(params, view_context: view_context)
        }
      end
    end

    # This action allow admins to manually toggle confirmation state of another user
    def toggle_confirmation
      if user_params[:to_confirm] == 'true'
        @user.confirm
      elsif user_params[:to_confirm] == 'false'
        @user.confirmed_at = nil
        @user.save
      end
      head :ok
    end

    def show
      # Variable @show_attributes holds the attributes that are visible for the 'show' action
      # If you want to change the attributes that are shown in the 'show' action of users
      # add/remove the attributes in the following string array
      @show_attributes = %w(first_name last_name email username nickname affiliation title mobile biography registered attended roles created_at
                            updated_at sign_in_count current_sign_in_at last_sign_in_at
                            current_sign_in_ip last_sign_in_ip sign_in_country)
    end

    def update
      message = ''
      if params[:user] && !params[:user][:email].nil?
        if (new_email = params[:user][:email]) != @user.email
          message = " Confirmation email sent to #{new_email}. The new email needs to be confirmed before it can be used."
        end
      end

      if @user.update_attributes(user_params)
        redirect_to admin_users_path, notice: "Updated #{@user.name} (#{@user.email})!" + message
      else
        redirect_to admin_users_path, error: "Could not update #{@user.name} (#{@user.email}). #{@user.errors.full_messages.join('. ')}."
      end
    end

    def edit; end

    private

    def user_params
      params[:user].delete(:password) unless params[:user][:password].present?

      params.require(:user).permit(:email, :name, :first_name, :last_name, :password, :email_public, :biography,
                                   :mobile, :nickname, :affiliation, :avatar, :remove_avatar,:title, :is_admin, :username, :login, :is_disabled,
                                   :tshirt, :mobile, :volunteer_experience, :languages, :to_confirm, role_ids: [])
    end
  end
end
