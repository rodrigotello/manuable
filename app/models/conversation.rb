class Conversation < ActiveRecord::Base
  belongs_to :from, foreign_key: 'from_id', class_name: 'User'
  belongs_to :to, foreign_key: 'to_id', class_name: 'User'
  has_many :messages

  scope :for, lambda { |uid| where { (from_id == uid) | (to_id == uid) } }
  scope :between, lambda { |to,from|
    where { (from_id == to) & (to_id == from) | (from_id == from) & (to_id == to) }
  }

  validates :from_id, :to_id, :body, presence: true
  before_validation :setups

  #after_create :deliver_notification

  def read! user
    update_attribute :unread_by_id, nil if unread_by_id == user.id
  end

  def unread_by? user
    unread_by_id == user.id
  end

  def name user
    sender(user).name
  end

  def sender(user)
    from_id == user.id ? to : from
  end

  private

  def setups
    if new_record?
      write_attribute :unread_by_id, to_id
      write_attribute :last_message, body
    end
  end

  #def deliver_notification
    #ConversationMailer.new_conversation(self).deliver
  #end
end
