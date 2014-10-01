class OrderAddressesController < ApplicationController
  def new
  	@address = OrderAddress.new
  end

  def create
    @address = current_user.order_address.build(order_address_params)
    if @address.save
      flash[:success] = "Address created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def delete
  end

  def update
  end
end
