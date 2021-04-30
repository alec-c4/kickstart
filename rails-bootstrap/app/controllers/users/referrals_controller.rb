class Users::ReferralsController < CustomerController
  def index
    authorize %i[users referrals], :index?
  end
end
