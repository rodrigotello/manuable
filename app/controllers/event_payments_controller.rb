# encoding: utf-8
class EventPaymentsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
  end

  def update
    @payment = EventPayment.where(user_id: current_user.id).find params[:id]
    if Rails.env.development?
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
      res = gateway.purchase(@payment.grand_total, cc, { currency: 'MXN', order_id: @payment.id, description: "Cuota evento #{@payment.event.name}", billing_address: {address1: address, zip: params[:event_payment][:card][:post_code], phone: params[:event_payment][:card][:phone]} , email: 'cesar@letwrong.com'})

      if res.success?
        @payment.update_attribute :paid, true
        flash[:notice] = 'Gracias por ser parte de este evento. Nos estaremos comunicando a la brevedad posible.'
        redirect_to root_path
      else
        logger.info(res.inspect)
        flash[:error] = 'No pudimos procesar tu pago'
        redirect_to :back
      end
    else
    end

  end
end
