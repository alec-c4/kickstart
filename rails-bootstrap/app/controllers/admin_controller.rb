class AdminController < ApplicationController
  layout "admin"
  before_action :check_admin

  private

  def check_admin
    raise Pundit::NotAuthorizedError unless signed_in? && current_user.is_admin?
  end
end
