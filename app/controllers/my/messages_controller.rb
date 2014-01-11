class My::MessagesController < ApplicationController
  before_filter :authenticate_user!
  def create
    cid = params[:conversation_id]
    @conversation = Conversation.for(current_user).includes(:from, :to, :messages).find(cid)

    @message = @conversation.messages.new message_params.merge(:from_id => current_user.id)
    respond_to do |wants|
      if @message.save
        wants.html { redirect_to [:my, @conversation] }
        wants.js { }
      else
        wants.html { redirect_to [:my, @conversation] }
        wants.js { }
      end
    end
  end
  private

  def message_params
    params.require(:message).permit(:body)
  end
end
