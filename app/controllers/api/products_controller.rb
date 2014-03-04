class Api::ProductsController < Api::ApplicationController

  def index
    @products = Product.feed(@current_user).page(params[:page])
  end

  def show
    @product = Product.feed(@current_user).find(params[:id])
  end

  def like
    @product = Product.find(params[:id])
    @like = @current_user.like! @product
  end
end
