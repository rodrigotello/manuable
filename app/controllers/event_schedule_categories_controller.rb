class EventScheduleCategoriesController < ApplicationController
  before_filter :authenticate_user!, :find_event_and_authorize

  def create
    @category = @event.event_schedule_categories.create params[:event_schedule_category]
    respond_to do |wants|
      wants.json { render json: @category }
      wants.html { redirect_to :back }
    end
  end

  def destroy
    @event.event_schedule_categories.find(params[:id]).destroy
    respond_to do |wants|
      wants.json { render json: @category }
      wants.html { redirect_to :back }
    end
  end

  private

  def find_event_and_authorize
    @event = Event.find params[:event_id]
    redirect_to @event unless @event.user_ids.include?(current_user.id)
  end
end
