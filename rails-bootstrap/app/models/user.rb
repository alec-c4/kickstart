class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
      :confirmable, :lockable, :timeoutable, :trackable,
      :recoverable, :rememberable, :trackable, :validatable, :pwned_password
     
    has_person_name

    validates :first_name, :last_name, presence: true
  
    before_destroy :delete_photo
  
    def is_admin?
      true #TODO rewrite with actual code
    end

    # scopes
    default_scope { order(created_at: :asc) }
  
    ### Photo
    has_one_attached :photo
  
    def delete_photo
      photo&.purge
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
  
    def to_s
      name&.familiar
    end
  end
  