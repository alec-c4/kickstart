class Admin::AnnouncementsController < AdminController
  before_action :set_announcement, only: %i[show edit update destroy]

  # GET /admin/announcements or /admin/announcements.json
  def index
    @announcements = Announcement.all
  end

  # GET /admin/announcements/1 or /admin/announcements/1.json
  def show; end

  # GET /admin/announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /admin/announcements/1/edit
  def edit; end

  # POST /admin/announcements or /admin/announcements.json
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.publisher = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to [:admin, @announcement], notice: "Announcement was successfully created." }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/announcements/1 or /admin/announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to [:admin, @announcement], notice: "Announcement was successfully updated." }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/announcements/1 or /admin/announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to admin_announcements_url, notice: "Announcement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def announcement_params
    params.require(:announcement).permit(:published_at, :announcement_type, :name, :description)
  end
end
