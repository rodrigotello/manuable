class Api::ProductsController < Api::ApplicationController

  def show
    @product = Product.feed(current_user).find(params[:id])
  end

  def like
    @product = Product.find(params[:id])
    @like = current_user.like! @product
  end
end
