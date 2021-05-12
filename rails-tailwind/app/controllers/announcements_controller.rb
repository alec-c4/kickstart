class AnnouncementsController < ApplicationController
  before_action :mark_as_read, if: :user_signed_in?

  def index
    @pagy, @announcements = pagy Announcement.where("published_at < ?", Time.zone.now).order(published_at: :desc)
  end

  private

  def mark_as_read
    current_user.update(announcements_last_read_at: Time.zone.now)
  end
end
