class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_identity
  before_action :set_user

  attr_reader :identity, :user

  User::OAUTH_PROVIDERS.each do |m|
    define_method m do
      handle_auth m.capitalize
    end
  end

  private

  def handle_auth(kind)
    if identity.present?
      identity.update(identity_attrs)
    else
      user.identities.create(identity_attrs)
    end

    if signed_in?
      redirect_to root_path
    else
      sign_in_and_redirect user, event: :authentication
      set_flash_message :notice, :success, kind: kind
    end
  end

  def auth
    request.env["omniauth.auth"]
  end

  def set_identity
    @identity = Identity.where(provider: auth.provider, uid: auth.uid).first
  end

  def set_user
    @user = if signed_in?
              current_user
            elsif identity.present?
              identity.user
            else
              User.find_or_create_by(email: auth.info.email) do |u|
                u.name = auth.info.name
                u.password = Devise.friendly_token[0, 20]

                referrer = User.find_by(referral_code: cookies[:referral_code])
                u.referred_by = referrer if cookies[:referral_code] && referrer.present?

                u.time_zone = browser_time_zone.name

                u.skip_confirmation!
              end
            end
  end

  def identity_attrs
    {
      provider: auth.provider,
      uid: auth.uid
    }
  end
end
