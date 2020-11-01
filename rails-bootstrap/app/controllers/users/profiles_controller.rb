class Users::ProfilesController < CustomerController
    def show
      @user = current_user
    end
  
    def edit
    end
  
    def update
      flash[:notice] = t("users.profiles.update_successful") if current_user.update(profile_params)
      redirect_to profile_path
    end
  
    def profile_params
      params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :photo)
    end
  end
  