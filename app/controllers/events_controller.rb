class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :map]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @events = @user.events
  end

  def publish
    @event = Event.find params[:id]
    redirect_to @event and return unless @event.user_ids.include?(current_user.id) || god_mode?
  end

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
                                  :ends_at_date, :artisan_ids, :event_schedules_attributes => [:name, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time],
                                  :attachments_attributes => [:name, :attachment])
  end
end
