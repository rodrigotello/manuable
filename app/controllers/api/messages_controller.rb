# users/TO/messages

class Api::MessagesController < Api::ApplicationController
  before_filter :hard_authenticate!
  before_filter :find_conversation_and_user

  def index
    @messages = @conversation.messages.page(params[:page]).per(20)
  end

  def create
    @message = @conversation.messages.create message_params.merge(:from_id => @current_user.id)
  end

  private

  def find_conversation_and_user
    @user = User.find params[:user_id]
    @conversation = Conversation.between(@current_user.id, @user.id).first

    unless @conversation
      @conversation = Conversation.create from_id: @current_user.id, to_id: @user.id
    end
  end

  def message_params
    params.permit(:body)
  end
end
