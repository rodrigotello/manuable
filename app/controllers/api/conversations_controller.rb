class ConversationsController < Api::ApplicationController
  before_filter :hard_authenticate!

  def index
    @conversations = Conversation.for(@current_user).includes(:from, :to).order('conversations.created_at DESC')
  end

  def create
    @conversation = Conversation.new conversation_params.merge(from_id: current_user.id)
    if @conversation.save
      redirect_to :back
    else
      @conversations = Conversation.for(current_user).includes(:from, :to).order('conversations.created_at DESC')
      render action: :new
    end
  end

  def show
    @conversation = Conversation.for(current_user.id).includes(:from, :to, :messages).find(params[:id])
    @conversation.read! current_user
    @conversations = Conversation.for(current_user.id).includes(:from, :to).order('conversations.created_at DESC')
  end

  private
  def conversation_params
    params.require(:conversation).permit(:body, :to_id)
  end
end
