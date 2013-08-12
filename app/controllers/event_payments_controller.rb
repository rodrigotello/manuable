# encoding: utf-8
require 'banwire_oxxo'

class EventPaymentsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
  end

  def update
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
    # if Rails.env.development?
      gateway = ActiveMerchant::Billing::BanwireGateway.new login: 'manuable'

      name = params[:event_payment][:card][:card_name]
      lastname = params[:event_payment][:card][:card_lastname]
      number = params[:event_payment][:card][:card_num]

      month = params[:event_payment][:card][:card_exp_month]
      year = params[:event_payment][:card][:card_exp_year]
      cvv = params[:event_payment][:card][:card_ccv2]
      phone = params[:event_payment][:card][:phone]
      address = params[:event_payment][:card][:address]

      cc = ActiveMerchant::Billing::CreditCard.new number: number, first_name: name, last_name: lastname, month: month, year: year, verification_value: cvv, brand: params[:event_payment][:card][:brand]
      res = gateway.purchase(@payment.grand_total, cc, { currency: 'MXN', order_id: @payment.id, description: "Cuota evento #{@payment.event.name}", billing_address: {address1: address, zip: params[:event_payment][:card][:post_code], phone: params[:event_payment][:card][:phone]} , email: current_user.email })

      if res.success?
        @payment.update_attribute :paid, true
        flash[:notice] = 'Gracias por ser parte de este evento. Nos estaremos comunicando a la brevedad posible.'
        redirect_to root_path
      else
        logger.info(res.inspect)
        flash[:error] = 'No pudimos procesar tu pago'
        redirect_to :back
      end
    # else
    # end

  end

  def oxxo_payment
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
    c = BanwireOxxo.new referencia: @payment.id,
                        dias_vigencia: 5,
                        monto: @payment.grand_total,
                        url_respuesta: 'http://www.manuable.com/event_payment/oxxo_success',
                        cliente: current_user.name,
                        email: current_user.email,
                        sendPDF: true,
                        usuario: 'manuable',
                        format: 'JSON'
    c.send!
    if c.successful?
      @payment.oxxo_ready = true
      @payment.oxxo_expires_on = c.response['response[fecha_vigencia]']
      @payment.oxxo_barcode = c.response['response[barcode]']
      @payment.save

      c.store_barcode File.join Rails.root, "/app/assets/event_payment_barcodes/#{@payment.id}"
      redirect_to :back
    else
      @errors = c.errors
      render action: :show
    end
  end
end

