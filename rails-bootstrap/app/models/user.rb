class User < ApplicationRecord
  include PgSearch::Model

  devise :database_authenticatable, :registerable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :recoverable, :rememberable, :trackable, :validatable,
         :pwned_password, :masqueradable,
         :omniauthable, omniauth_providers: OAUTH_PROVIDERS

  encrypts :email, :unconfirmed_email
  blind_index :email, :unconfirmed_email

  has_many :identities, dependent: :destroy
  belongs_to :banned_by, class_name: "User", optional: true
  belongs_to :referred_by, class_name: "User", optional: true
  has_many :referred_users, class_name: "User", foreign_key: :referred_by_id,
                            inverse_of: :referred_by, dependent: :nullify
  has_many :visits, class_name: "Ahoy::Visit", dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  rolify

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validate :check_name_format, on: :create

  validates :referral_code, uniqueness: true

  before_create :set_referral_code
  after_create :complete_referral!
  before_destroy :delete_photo

  ### Search
  pg_search_scope :search,
                  against: %i[email first_name last_name],
                  using: {
                    tsearch: { prefix: true },
                    trigram: {}
                  }

  pg_search_scope :search_by_email,
                  against: %i[email],
                  using: { tsearch: { any_word: true } }

  multisearchable against: %i[first_name last_name email]

  # scopes
  default_scope { order(created_at: :asc) }

  ### Photo
  has_one_attached :photo

  def delete_photo
    photo&.purge
  end

  ### Ban
  def account_active?
    banned_at.nil?
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    # i18n-tasks-use t('devise.failure.banned')
    account_active? ? super : :banned
  end

  ### Referral
  def set_referral_code
    loop do
      self.referral_code = SecureRandom.hex(6)
      break unless self.class.exists?(referral_code: referral_code)
    end
  end

  def complete_referral!
    update(referral_completed_at: Time.zone.now)
    # TODO: add credit to referred_by user
  end

  ### Devise async
  def send_devise_notification(notification, *args)
    if Rails.env.production?
      devise_mailer.send(notification, self, *args).deliver_later
    else
      devise_mailer.send(notification, self, *args).deliver_now
    end
  end

  ### Name
  def name=(full_name)
    self.first_name, self.last_name = full_name.to_s.squish.split(/\s/, 2)
  end

  def name
    [first_name, last_name].join(" ")
  end

  def check_name_format
    errors.add(:name, I18n.t("activerecord.errors.messages.wrong_name_format")) unless name.match?(/^\S+\s\S+$/)
  end

  def to_s
    name
  end

  def flipper_id
    "#{self.class.name};#{id}"
  end
end
