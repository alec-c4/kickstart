class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    if params[:query].blank?
      @pagy, @users = pagy(User.order("created_at DESC"))
    else
      @pagy, @users = pagy(User.search(params[:query]).order("created_at DESC"))
    end
  end

  def show; end

  def edit; end

  def update
    @user.skip_reconfirmation!
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: "User info updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "User deleted" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :name, :gender, :birthday, :photo, :time_zone)
  end
end
