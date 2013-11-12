class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :map]

  def show
    @event = Event.includes(:artisans => :last_product).find params[:id]
    redirect_to root_path unless @event.paid || current_user && @event.user_ids.include?(current_user.id) || god_mode?

    @images = Hash[*@event.artisans.collect {|art|
          next if art.last_product.nil? || art.last_product.attachments.first.nil?
          [art.id, art.last_product.attachments.first]
        }.compact.flatten]
  end

  def map
    @event = Event.find params[:id]
  end

  def edit
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id) || god_mode?

  end

  def update
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id) || god_mode?

    params[:event][:user_ids] = params[:event][:user_ids].split(',') if params[:event][:user_ids].present?
    params[:event][:artisan_ids] = params[:event][:artisan_ids].split(',').map(&:to_i) if params[:event][:artisan_ids].present?

    if @event.update_attributes params[:event]

      if params[:event][:artisan_ids].present?
        ids = @event.event_requests.pluck :user_id
        @event.event_requests.where(user_id: params[:event][:artisan_ids]).update_all('accepted = true')
        @event.event_requests.where(" event_requests.user_id NOT IN (?)", params[:event][:artisan_ids]).update_all('accepted = false')
      else
        @event.event_requests.update_all('accepted = false')
      end

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
    params[:event][:user_ids] = [current_user.id]
    @event = Event.new params[:event]

    @event.user_id = current_user.id

    if @event.save
      redirect_to @event
    else
      render action: :new
    end
  end
end
