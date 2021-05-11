class Customer::NotificationsController < CustomerController
  def index
    @notifications = current_user.notifications
    authorize @notifications
  end
end