class OrdersController < ApplicationController
  def new
  end

  def save
  end

  def delete
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
  
end
