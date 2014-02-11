class Notification < ActiveRecord::Base
  # attr_accessible :comment_id, :code, :read, :from_id, :product_id
  belongs_to :sender, foreign_key: :from_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :to_id, class_name: 'User', inverse_of: :notifications
  belongs_to :product

  scope :unread, where(read: false)
  scope :recent_first, order('notifications.created_at DESC')

  after_create :notify_by_email

  def read!
    update_attribute :read, true
  end

  private

  def notify_by_email
    case code
    when 'liked'
      UserMailer.like(sender, product, recipient).deliver
    end
  end
end
