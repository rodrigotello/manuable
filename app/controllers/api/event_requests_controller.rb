class Api::EventRequestsController < Api::ApplicationController
  before_filter :authenticate_user!

  def update
    @event_request = EventRequest.find params[:id]
    if current_user.events.where(id: @event_request.event_id).exists?
      @event_request.update_attribute :accepted, true
    end
    redirect_to :back
  end

  def destroy
    @event_request = EventRequest.find params[:id]
    if current_user.events.where(id: @event_request.event_id).exists?
      @event_request.update_attribute :accepted, false
    end
    redirect_to :back
  end
end
