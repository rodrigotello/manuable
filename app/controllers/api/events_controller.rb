class Api::EventsController < Api::ApplicationController

  def index
    @events = Event.filter(params).page(params[:page])
  end

  def show
    @event = Event.includes(:artisans => :last_product).find params[:id]
  end

end
