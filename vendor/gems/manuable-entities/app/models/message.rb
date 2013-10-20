class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :from_id
  belongs_to :conversation
  belongs_to :from, foreign_key: 'from_id', class_name: 'User'

  after_create :set_conversation_last_message
  after_create :deliver_notification

  default_scope order('id ASC')

  private

  def set_conversation_last_message
    conversation.last_message = body
    conversation.unread_by_id = conversation.sender(from).id
    conversation.save
  end

  def deliver_notification
    ConversationMailer.new_message(self).deliver
  end
end
