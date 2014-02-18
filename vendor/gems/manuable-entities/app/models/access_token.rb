class AccessToken < ActiveRecord::Base
  TTL = 1.week
  belongs_to :user

  scope :valid, -> { where { expires_at > DateTime.now } }

  before_create :setup_token

  private

  def setup_token
    write_attribute :token, SecureRandom.base64(64)
    write_attribute :expires_at, DateTime.now + TTL
  end
end
