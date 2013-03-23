class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :name, :nickname

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]


  has_many :authentications

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
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

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20]
            )
        user.authentications.create(provider: 'google', uid: auth.uid)
    end
    user
  end

  def self.find_for_twitter_oauth(omniauth)
    transaction do
      authentication = Authentication.where(provider: omniauth['provider'], uuid: omniauth['uid']).first

      if authentication && authentication.user
        authentication.user
      else

        screen_name = omniauth["info"]["nickname"]
        name = omniauth["info"]["name"]
        avatar = omniauth["info"]["image"]

        password = SecureRandom.hex(4)
        user = User.create!(nickname: screen_name,
                            name: name,
                            email: "#{screen_name}@manuablefakeemail.com",
                            password: password,
                            password_confirmation: password)
        user.authentications.create!(:provider => omniauth['provider'], :uuid => omniauth['uid'])
        user.save
        user
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
