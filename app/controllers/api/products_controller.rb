class Api::ProductsController < Api::ApplicationController
  before_filter :hard_authenticate!, only: :likes

  def index
    @products = Product.filter(params).feed(@current_user).page(params[:page])
  end

  def show
    @product = Product.feed(@current_user).find(params[:id])
  end

  def likes
    @product = Product.find(params[:id])
    @like = @current_user.like! @product
  end
end
