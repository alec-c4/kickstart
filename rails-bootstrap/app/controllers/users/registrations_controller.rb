class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash = {})
    super

    if cookies[:referral_code] && (referrer = User.find_by(referral_code: cookies[:referral_code]))
      resource.referred_by = referrer
    end

    resource.time_zone = browser_time_zone.name
  end
end
