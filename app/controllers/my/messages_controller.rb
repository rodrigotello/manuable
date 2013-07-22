class My::MessagesController < ApplicationController
  before_filter :authenticate_user!
  def create
    @conversation = Conversation.for(current_user).includes(:from, :to, :messages).find(params[:conversation_id])
    params[:message][:from_id] = current_user.id
    @message = @conversation.messages.new params[:message]
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
end
