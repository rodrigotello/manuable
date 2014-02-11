class ConversationMailer < ActionMailer::Base
  default from: "noreply@manuable.com"
  layout 'user_mailer'

  helper ApplicationHelper

  def new_conversation conversation
    @conversation = conversation
    @from = conversation.from
    @to = conversation.to
    mail(:to => @to.email, subject: "[Manuable] Nuevo mensaje de #{@conversation.from.name}")
  end

  def new_message message
    @to = message.from == message.conversation.from ? message.conversation.to : message.conversation.from
    @conversation = message.conversation
    @message = message
    @from = message.from
    mail(:to => @to.email, subject: "[Manuable] Nuevo mensaje de #{@from.name}")
  end
end
