class EventsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @event = Event.find params[:id]
  end

  def checkout
    @event = Event.find params[:id]

    if request.post?
      @payment = @event.generate_payments(params, current_user)
      @payment.save
      redirect_to @payment
    end
  end

  def pay
    if request.post?
    end
  end

  def new
    @event = Event.new spaces: 1
    @event.event_products.build name: 'Mesa adicional', price: 50
  end

  def create
    @event = Event.new params[:event]
    @event.user_id = current_user.id

    if @event.save
      redirect_to @event
    else
      render action: :new
    end
  end
end
