class CartsController < ApplicationController
  
  def index
  	@carts = current_user.carts
  end

  def new
  	current_user.carts.create(product_id: params[:product_id])
  	redirect_to carts_path
  end

  def destroy
  	@carts = current_user.carts
    Cart.find(params[:id]).destroy
  	redirect_to carts_path
  end

  def show
  end

  def shipping_local
    @c = Cart.find(params[:id])
    @c.toggle!(:shipping_boolean)
    respond_to do |format|
      format.html {redirect_to carts_path}
      format.js
    end
  end

end
