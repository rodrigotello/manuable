#encoding: utf-8

class OrderAddressesController < ApplicationController
  def new
  	@address = OrderAddress.new
  end

  def create
    @address = OrderAddress.build(order_address_params)
    if @address.save
      flash[:success] = "Tienes una nueva dirección de envio."
      redirect_to root_url
    else
      redirect_to new_order_path
    end
  end

  def delete
  end

  def update
  end
end
