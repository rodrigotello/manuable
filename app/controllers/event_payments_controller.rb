# encoding: utf-8
require 'banwire_oxxo'

class EventPaymentsController < ApplicationController
  before_filter :authenticate_user!, except: :oxxo_success

  def show
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
  end

  def update
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]

    if params[:conektaChargeId].present? && !@payment.paid
      @payment.conekta_charge_id = params[:conektaChargeId]
      @payment.position = (params[:event_payment] || {})[:position]
      @payment.save
      flash[:notice] = 'Gracias por ser parte de este evento. Tu pago está siendo validado.'
    end
    redirect_to @payment.event
    # if Rails.env.development?
      # gateway = ActiveMerchant::Billing::BanwireGateway.new login: 'manuable'

      # name = params[:event_payment][:card][:card_name]
      # lastname = params[:event_payment][:card][:card_lastname]
      # number = params[:event_payment][:card][:card_num]

      # month = params[:event_payment][:card][:card_exp_month]
      # year = params[:event_payment][:card][:card_exp_year]
      # cvv = params[:event_payment][:card][:card_ccv2]
      # phone = params[:event_payment][:card][:phone]
      # address = params[:event_payment][:card][:address]

      # cc = ActiveMerchant::Billing::CreditCard.new number: number, first_name: name, last_name: lastname, month: month, year: year, verification_value: cvv, brand: params[:event_payment][:card][:brand]
      # res = gateway.purchase(@payment.grand_total*100, cc, { currency: 'MXN', order_id: @payment.id, description: "Cuota evento #{@payment.event.name}", billing_address: {address1: address, zip: params[:event_payment][:card][:post_code], phone: params[:event_payment][:card][:phone]} , email: current_user.email })

      # if res.success?
        # @payment.paid = true
        # @payment.position = params[:event_payment][:position]
        # @payment.save
        # flash[:notice] = 'Gracias por ser parte de este evento. Nos estaremos comunicando a la brevedad posible.'
        # redirect_to root_path
      # else
        # logger.info(res.inspect)
        # flash[:error] = 'No pudimos procesar tu pago'
        # redirect_to :back
      # end
    # else
    # end

  end

  # def oxxo_success
  #   @payment = EventPayment.where(oxxo_barcode: params[:cb], id: params[:referencia]).first!
  #   @payment.paid = true
  #   @payment.amount_paid = params[:monto]
  #   @payment.save
  #   head :ok
  # end

  def oxxo_payment
    # redirect_to :back and return unless params[:position].present?

    @payment = EventPayment.where(user_id: current_user.id).find params[:id]

    charge = Conekta::Charge.create({
      currency: "MXN",
      amount: @payment.grand_total * 100,
      description:  "Participanción evento Manuable $ #{@payment.grand_total} MXN",
      reference_id: "eventpayment-#{@payment.id}",
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

    @payment.oxxo_expires_on = Date.parse charge.payment_method.expiry_date.scan(/.{2}/).reverse.join('-')
    @payment.oxxo_ready = true
    @payment.oxxo_barcode = charge.payment_method.barcode
    @payment.barcode_url = charge.payment_method.barcode_url
    @payment.position = params[:position]
    @payment.save

    #   c.store_barcode File.join Rails.root, "/public/uploads/event_payment_barcodes/#{@payment.id}"
      redirect_to :back
    # else
      # @errors = c.errors
      # render action: :show
    # end
  end
end

