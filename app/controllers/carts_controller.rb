class CartsController < ApplicationController
  
  def index
  	@carts = current_user.cart_products	
  end

  def new
  	current_user.carts.create(product_id: params[:product_id])
  	redirect_to carts_path
  end

  def delete
  	@products = current_user.cart_products
	current_user.carts.find(params[:id]).delete
  	redirect_to carts_path
  end

  def show
  end
end
