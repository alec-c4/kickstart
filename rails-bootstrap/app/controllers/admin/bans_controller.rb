class Admin::BansController < AdminController
  def create
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update(banned_at: Time.current, banned_by: current_user, ban_reason: params[:ban_reason] || "")
        format.html { redirect_to [:admin, @user], notice: "Ban added" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.update(banned_at: nil, banned_by: nil, ban_reason: "")
    respond_to do |format|
      format.html { redirect_to [:admin, @user], notice: "Ban removed" }
      format.json { head :no_content }
    end
  end
end
