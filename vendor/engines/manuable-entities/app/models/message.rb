class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :from_id
  belongs_to :conversation
  belongs_to :from, foreign_key: 'from_id', class_name: 'User'

  after_create :set_conversation_last_message

  default_scope order('id ASC')

  private

  def set_conversation_last_message
    conversation.last_message = body
    conversation.unread_by_id = conversation.sender(from).id
    conversation.save
  end
end
