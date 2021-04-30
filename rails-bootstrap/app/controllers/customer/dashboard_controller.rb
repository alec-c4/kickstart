class Customer::DashboardController < CustomerController
  def index
    authorize %i[customer dashboard], :index?
  end
end
