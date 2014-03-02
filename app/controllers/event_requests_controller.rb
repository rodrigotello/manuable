class EventRequestsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @event = Event.find params[:event_id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id) || god_mode?
    @event_requests = @event.event_requests
  end

  def update
    @event_request = EventRequest.find params[:id]
    redirect_to @event_request.event and return unless @event_request.event.user_ids.include?(current_user.id) || god_mode?

    # if current_user.events.where(id: @event_request.event_id).exists?
      @event_request.update_attribute :accepted, true
    # end
    #
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { }
    end
  end

  def destroy
    @event_request = EventRequest.find params[:id]

    redirect_to @event_request.event and return unless @event_request.event.user_ids.include?(current_user.id) || god_mode?

    # if current_user.events.where(id: @event_request.event_id).exists?
      @event_request.update_attribute :accepted, false
    # end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { }
    end
  end
end
