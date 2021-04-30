class Users::ProfilesController < CustomerController
  def show
    @user = current_user
    authorize %i[users profiles], :show?
  end

  def edit
    @user = current_user
    authorize %i[users profiles], :edit?
  end

  def update
    @user = current_user
    authorize %i[users profiles], :update?

    respond_to do |format|
      if @user.update(profile_params)
        format.html { redirect_to profile_path, notice: t("users.profiles.update_successful") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :photo, :time_zone)
  end
end
