#encoding: utf-8

class OrderAddressesController < ApplicationController
  
  def index
    
  end

  def new
  	@address = current_user.order_addresses.new
  end

  def create
    @address = current_user.order_addresses.create(street: params[:order_address][:street], in_between_street: params[:order_address][:in_between_street], number: params[:order_address][:number], inner_number: params[:order_address][:inner_number], neighborhood: params[:order_address][:neigborhood], zip: params[:order_address][:zip], reference: params[:order_address][:reference])
    #if @address.save
      #flash[:success] = "Tienes una nueva dirección de envio."
      #redirect_to new_order_path
    #else
      redirect_to new_order_path
    #end
  end

  def delete
  end

  def update
  end

  #Not sure if this line from below are still working. It was used when using the method
  private

  def data_params
    params.require(:order_address).permit( :street, :in_between_street, :number, :inner_number, :neighborhood, :zip, :reference)
  end
end
