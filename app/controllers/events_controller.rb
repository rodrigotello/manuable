class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :map, :webhook]
  protect_from_forgery :except => [:webhook]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @events = @user.events
  end

  def webhook
    # "id"=>"51cef9faf23668b1f4000001", "created_at"=>1390540322, "livemode"=>true, "type"=>"charge.paid", "data"=>{"object"=>{"id"=>"51d5ea80db49596aa9000001", "created_at"=>1390540317, "amount"=>10000, "fee"=>310, "currency"=>"MXN", "status"=>"paid", "livemode"=>true, "description"=>"E-Book: Les Miserables", "error"=>nil, "error_message"=>nil, "payment_method"=>{"object"=>"card_payment", "last4"=>"1111", "name"=>"Arturo Octavio Ortiz", "dispute"=>nil}}, "previous_attributes"=>{"status"=>"payment_pending"}}, "event"=>{"id"=>"51cef9faf23668b1f4000001", "created_at"=>1390540322}}

    if params[:livemode] && params[:type] == 'charge.paid' && params[:data][:object][:status] == 'paid'
      if params[:data][:object][:reference_id].split('-')[0] == 'event'
        @event = Event.find(params[:data][:object][:reference_id].split('-')[1])

        if @event.total * 100 == params[:data][:object][:amount]
          @event.paid = true
          @event.save
        end
      end

      if params[:data][:object][:reference_id].split('-')[0] == 'eventpayment'
        @event_payment = EventPayment.find(params[:data][:object][:reference_id].split('-')[1])

        if @event_payment.grand_total * 100 == params[:data][:object][:amount]
          @event_payment.paid = true
          @event_payment.save
        end
      end

    end

    head :ok
  end

  def publish
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id) || god_mode?

    if request.post? && params[:conektaChargeId].present? && !@event.paid
      @event.conekta_charge_id = params[:conektaChargeId]
      @event.save
      redirect_to @event
    end

  end

  def show
    @event = Event.includes(:artisans => :last_product).find params[:id]
    redirect_to root_path and return unless @event.paid || current_user && @event.user_ids.include?(current_user.id) || god_mode?

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

    event_params[:user_ids] = event_params[:user_ids].split(',') if event_params[:user_ids].present?
    event_params[:artisan_ids] = event_params[:artisan_ids].split(',').map(&:to_i) if event_params[:artisan_ids].present?

    if @event.update_attributes event_params
      if event_params[:artisan_ids].present?
        ids = @event.event_requests.pluck :user_id
        @event.event_requests.where(user_id: event_params[:artisan_ids].take(@event.spaces)).update_all('accepted = true')
        @event.event_requests.where(" event_requests.user_id NOT IN (?)", event_params[:artisan_ids].take(@event.spaces)).update_all('accepted = false')
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
    @event.event_schedules.build
    @event.users << current_user
  end

  def create
    @event = Event.new event_params

    @event.user_id = current_user.id

    if @event.save
      redirect_to @event
    else
      render action: :new
    end
  end

  private
  def event_params
    @event_params ||= params.require(:event).permit(:name, :slug, :description, :benefits,
                                  :notes, :requirements, :info_for_accepted_users,
                                  :user_ids, :address, :zip, :location, :city_id,
                                  :location_name, :lat, :lng, :spaces, :plan_id,
                                  :starts_at_date, :starts_at_time, :ends_at_time,
                                  :location_map, :cover,
                                  :ends_at_date, :artisan_ids, :event_schedules_attributes => [:id, :_destroy, :name, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time],
                                  :attachments_attributes => [:id, :name, :attachment, :_destroy], :event_sale_categories_attributes => [:id, :name, :price, :_destroy])
  end
end
