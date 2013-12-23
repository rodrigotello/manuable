class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :avatar, :name, :nickname, :remote_avatar_url, :city_id, :state_id,
                  :address, :zipcode, :occupation, :about, :birthday, :nickname
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  belongs_to :state
  belongs_to :city
  belongs_to :last_product, class_name: "Product", foreign_key: 'last_product_id'
  has_many :authentications, dependent: :destroy
  has_many :products, dependent: :destroy

  has_many :my_followings, foreign_key: 'follower_id', class_name: "Following", dependent: :destroy
  has_many :followees, through: :my_followings, source: :followee, dependent: :destroy

  has_many :followings, foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :followings, source: :follower, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  has_many :notifications, foreign_key: :to_id
  has_and_belongs_to_many :events
  has_many :event_requests, through: :events

  validates :email, uniqueness: true, allow_nil: true, allow_blank: true
  validates :about, length: { maximum: 100 }, allow_nil: true, allow_blank: true
  validates_with UserEventSlugValidator

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  after_create :notify_signup
  before_create :grab_avatar
  after_update :crop_avatar

  def slug
    nickname
  end

  def as_json options={}
    {
      id: id,
      name: name,
      value: name,
      label: name,
      nickname: nickname,
      avatar: avatar.url(:small),
      profileImageUrl: avatar.url(:small)
    }
  end

  def seller_ready?
    email.present? && name.present? && avatar.present? && about.present? && products.count > 0
  end

  def has_notifications?
    conversations.where(unread_by_id: self.id).count > 0 || event_requests.where(accepted: nil).count > 0
  end

  def missing_seller_info
    arr = []
    arr << 'Correo' if email.blank?
    arr << 'Nombre'  if name.blank?
    arr << 'Tu foto' if avatar.blank?
    arr << 'Acerca de ti' if about.blank?
    # arr << 'Tus productos' if products.count == 0
    arr
  end

  def like! product
    likes.where(product_id: product.id).first_or_create
  end

  def follow_to! user
    Following.where( followee_id: user.id, follower_id: self.id ).first_or_create
  end

  def followed_by? user
    Following.exists?( follower_id: user.id, followee_id: self.id )
  end

  def first_name
    (name||'').split(/\s/)[0]
  end

  def location
    if city && state
      "#{city.name}, #{state.name}"
    else
      "#{city.try :name}#{state.try :name}"
    end
  end

  def conversations
    userid = id
    Conversation.where { (from_id == userid) | (to_id == userid) }
  end
  private

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def grab_avatar
    if avatar.blank?
      self.remote_avatar_url = "http://avatar.3sd.me/100"
    end
  end

  def notify_signup
    UserMailer.welcome_email(self).deliver
  end

  # CLASS
    class << self
      def find_for_facebook_oauth(auth, signed_in_resource=nil)
        transaction do
          authentication = Authentication.where(provider: auth.provider, uuid: auth.uid).first

          if authentication && authentication.user
            authentication.user
          else
            if user = User.where(email: auth.info.email).first
              user.authentications.create!(provider: auth.provider, uuid: auth.uid)
            else
              user = User.create( name: auth.extra.raw_info.name,
                                email: auth.info.email,
                                password: Devise.friendly_token[0,20],
                                remote_avatar_url: "http://graph.facebook.com/#{auth.uid}/picture?type=large"
                              )
              user.authentications.create!(provider: auth.provider, uuid: auth.uid)
            end
            user
          end
        end
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
