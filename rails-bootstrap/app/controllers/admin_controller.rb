class AdminController < ApplicationController
    before_action :check_admin
  
    private
  
    def check_admin
      raise Pundit::NotAuthorizedError unless signed_in? && current_user.admin?
    end
  end
  