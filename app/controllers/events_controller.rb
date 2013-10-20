class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :map]

  def show
    @event = Event.includes(:artisants => :last_product).find params[:id]
    @images = Hash[*@event.artisants.collect {|art|
          next if art.last_product.nil? || art.last_product.attachments.first.nil?
          [art.id, art.last_product.attachments.first]
        }.compact.flatten]
  end

  def map
    @event = Event.find params[:id]
  end

  def edit
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id)

  end

  def update
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id)

    params[:event][:user_ids] = params[:event][:user_ids].split(',')

    if @event.update_attributes params[:event]
      redirect_to @event
    else
      render action: :edit
    end
  end

  def request_access
    @event = Event.find params[:id]
    if request.post?
      @event.event_requests.create! user_id: current_user.id
      redirect_to @event
    end
  end

  def checkout
    @event = Event.find params[:id]

    if payment = @event.event_payments.where(user_id: current_user.id).first
      redirect_to payment and return
    end

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
    @event.event_sale_categories.build name: 'Comida', price: 500
    @event.event_sale_categories.build name: 'Otro', price: 200
    @event.attachments.build
  end

  def create
    params[:event][:user_ids] = params[:event][:user_ids].split(',')+[current_user.id]
    @event = Event.new params[:event]

    @event.user_id = current_user.id

    if @event.save
      redirect_to @event
    else
      render action: :new
    end
  end
end
