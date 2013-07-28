class My::ConversationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @conversations = Conversation.for(current_user).includes(:from, :to).order('conversations.created_at DESC')
    @event_requests = current_user.event_requests.where(accepted: nil).includes(:user, :event)
    @last_conversation = Conversation.for(current_user).includes(:from, :to, :messages).order('conversations.created_at DESC').first
    @last_conversation.read! current_user if @last_conversation
  end

  def create
    @conversation = Conversation.new params[:conversation].merge(from_id: current_user.id)
    if @conversation.save
      redirect_to [:my, @conversation]
    else
      @conversations = Conversation.for(current_user).includes(:from, :to).order('conversations.created_at DESC')
      render action: :new
    end
  end

  def new
    userid = current_user.id
    to = params[:to]
    if to && (@conversation = Conversation.where { (from_id == userid) | (to_id == userid) && (from_id == to) | (to_id == to)  }.first)
      redirect_to [:my, @conversation]
    else
      @conversations = Conversation.for(current_user).includes(:from, :to).order('conversations.created_at DESC')
      @conversation = Conversation.new from_id: current_user.id, to_id: params[:to]
    end
  end

  def show
    @conversation = Conversation.for(current_user).includes(:from, :to, :messages).find(params[:id])
    @conversation.read! current_user
    @conversations = Conversation.for(current_user).includes(:from, :to).order('conversations.created_at DESC')
  end
end
