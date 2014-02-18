class Api::EventSchedulesController < Api::ApplicationController
  before_filter :authenticate_user!, :find_event_and_authorize

  def create
    @event_schedule = @event.event_schedules.create params[:event_schedule].merge(event_schedule_category_id: @event_schedule_category.id)
    respond_to do |wants|
      wants.json { render json: @event_schedule }
      wants.html { redirect_to :back }
    end
  end

  def destroy
    @schedule = @event.event_schedules.find(params[:id])
    @schedule.destroy
    respond_to do |wants|
      wants.json { render json: @schedule }
      wants.html { redirect_to :back }
    end
  end

  private

  def find_event_and_authorize
    @event_schedule_category = EventScheduleCategory.find params[:event_schedule_category_id]
    @event = @event_schedule_category.event
    redirect_to @event unless @event.user_ids.include?(current_user.id)
  end
end
