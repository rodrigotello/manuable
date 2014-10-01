#encoding: utf-8
class OrdersController < ApplicationController
  def show
    @order = Order.find params[:id]
  end

  #def new
   # if current_user.order_addresses.count < 1 or nil
     # redirect_to new_order_address_path
    #else
      #total = 0
       # current_user.cart_products.each do |p|
        #  total += p.price
        #end
      #@order = Order.where(status: 0).first
      #if !@order.nil?
       # @order.destroy
      #end
       # @order = current_user.orders.create(total: total, status: 0)
        #redirect_to @order
    #end
  #end

  def new
      total = 0
        current_user.cart_products.each do |p|
          total += p.price
        end
      @order = Order.where(status: 0).first
      if !@order.nil?
        @order.destroy
      end
        @order = current_user.orders.create(total: total, status: 0)
        redirect_to @order
  end

  def save
  end

  def delete
  end

  def update
    @order = Order.where(user_id: current_user.id).find params[:id]

    if params[:conektaChargeId].present? && @order.status != 2
      @order.conekta_charge_id = params[:conektaChargeId]
      @order.save
      flash[:notice] = 'Gracias por comprar productos hechos a mano. Tu pago está siendo validado.'
    end
    current_user.carts.each do |c|
      @order.order_items.create(product_id: c.product_id)
      c.delete
    end
  end

  def oxxo_payment
    # redirect_to :back and return unless params[:position].present?

    @order = Order.where(user_id: current_user.id).find params[:id]
    charge = Conekta::Charge.create({
      currency: "MXN",
      amount: @order.grand_total * 100,
      description:  "Orden de compra Manuable $ #{@total} MXN",
      reference_id: "order-#{@order.id}",
      cash: {
        type: "oxxo"
      },
      details:  {
       name: current_user.name,
       email: current_user.email
      }
    })
    # @payment = EventPayment.where(user_id: current_user.id).find params[:id]
    # c = BanwireOxxo.new referencia: @payment.id,
    #                     dias_vigencia: 1,
    #                     monto: @payment.grand_total,
    #                     url_respuesta: 'https://www.manuable.com/event_payments/oxxo_success',
    #                     cliente: current_user.name,
    #                     email: current_user.email,
    #                     sendPDF: true,
    #                     usuario: 'manuable',
    #                     format: 'JSON'
    # c.send!
    # if c.successful?

    @order.oxxo_expires_on = Date.parse charge.payment_method.expiry_date.scan(/.{2}/).reverse.join('-')
    @order.oxxo_ready = true
    @order.oxxo_barcode = charge.payment_method.barcode
    @order.barcode_url = charge.payment_method.barcode_url
    @order.save

    #   c.store_barcode File.join Rails.root, "/public/uploads/event_payment_barcodes/#{@payment.id}"
      redirect_to :back
    # else
      # @errors = c.errors
      # render action: :show
    # end
  end

  def webhook
    # "id"=>"51cef9faf23668b1f4000001", "created_at"=>1390540322, "livemode"=>true, "type"=>"charge.paid", "data"=>{"object"=>{"id"=>"51d5ea80db49596aa9000001", "created_at"=>1390540317, "amount"=>10000, "fee"=>310, "currency"=>"MXN", "status"=>"paid", "livemode"=>true, "description"=>"E-Book: Les Miserables", "error"=>nil, "error_message"=>nil, "payment_method"=>{"object"=>"card_payment", "last4"=>"1111", "name"=>"Arturo Octavio Ortiz", "dispute"=>nil}}, "previous_attributes"=>{"status"=>"payment_pending"}}, "event"=>{"id"=>"51cef9faf23668b1f4000001", "created_at"=>1390540322}}

    if params[:livemode] && params[:type] == 'charge.paid' && params[:data][:object][:status] == 'paid'
      if params[:data][:object][:reference_id].split('-')[0] == 'event'
        @order = Order.find(params[:data][:object][:reference_id].split('-')[1])

        if @order.total * 100 == params[:data][:object][:amount]
          @order.paid = true
          @order.save
        end
      end

      if params[:data][:object][:reference_id].split('-')[0] == 'eventpayment'
        @event_payment = find.Order(params[:data][:object][:reference_id].split('-')[1])

        if @event_payment.grand_total * 100 == params[:data][:object][:amount]
          @event_payment.paid = true
          @event_payment.save
        end
      end

    end

    head :ok
  end
  
end
