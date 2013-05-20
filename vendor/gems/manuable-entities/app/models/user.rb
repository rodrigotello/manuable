class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :name, :nickname, :remote_avatar_url, :city_id, :state_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  belongs_to :state
  belongs_to :city
  has_many :authentications
  has_many :products

  has_many :my_followings, foreign_key: 'follower_id', class_name: "Following"
  has_many :followees, through: :my_followings, source: :followee

  has_many :followings, foreign_key: 'followee_id'
  has_many :followers, through: :followings, source: :follower

  has_many :likes
  has_many :liked_products, through: :likes, source: :product

  validates :nickname, :email, uniqueness: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  after_create :notify_signup

  def follow_to! user
    Following.where( followee_id: user.id, follower_id: self.id ).first_or_create
  end

  def followed_by? user
    Following.exists?( follower_id: user.id, followee_id: self.id )
  end

  def location
    if city && state
      "#{city.name}, #{state.name}"
    else
      "#{city.try :name}#{state.try :name}"
    end
  end
  private

  def notify_signup
    UserMailer.welcome_email(self).deliver
  end

  # CLASS
    class << self
      def find_for_facebook_oauth(auth, signed_in_resource=nil)
        authentication = Authentication.where(provider: auth.provider, uuid: auth.uid).first

        if authentication && authentication.user
          user = authentication.user
        else
          user = User.create( name: auth.extra.raw_info.name,
                              email: auth.info.email,
                              password: Devise.friendly_token[0,20]
                            )
          user.authentications.create(provider: auth.provider, uid: auth.uid)

        end
        user
      end

      def find_for_google_oauth2(access_token, signed_in_resource=nil)
        transaction do

          data = access_token.info
          user = User.where(:email => data["email"]).first
          password = Devise.friendly_token[0,20]

          authentication = Authentication.where(provider: access_token.provider, uuid: access_token.uid ).first

          if authentication && authentication.user
            authentication.user
          else
            user = User.create!(name: data["name"],
                 email: data["email"],
                 password: password,
                 password_confirmation: password
                )
            user.authentications.create!( provider: access_token.provider, uuid: access_token.uid  )
          end
          user
        end
      end

      def find_for_twitter_oauth(omniauth)
        transaction do
          authentication = Authentication.where(provider: omniauth['provider'], uuid: omniauth['uid']).first

          if authentication && authentication.user
            authentication.user

          else
            screen_name = omniauth["info"]["nickname"]
            name = omniauth["info"]["name"]
            remote_avatar_url = omniauth["info"]["image"]

            if user = User.where(email: "#{screen_name}@manuablefakeemail.com").first
              user.authentications.create!(:provider => omniauth['provider'], :uuid => omniauth['uid'])
            else
              password = SecureRandom.hex(4)
              user = User.create!(nickname: screen_name,
                                  name: name,
                                  email: "#{screen_name}@manuablefakeemail.com",
                                  password: password,
                                  password_confirmation: password,
                                  remote_avatar_url: remote_avatar_url)
              user.authentications.create!(:provider => omniauth['provider'], :uuid => omniauth['uid'])
              user.save

            end
            user
          end
        end
      end

      def new_with_session(params, session)
        super.tap do |user|
          if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
          end
        end
      end
    end
end
