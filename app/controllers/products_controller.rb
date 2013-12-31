class ProductsController < ApplicationController
  before_filter :authenticate_user!, only: :like
  respond_to :json, :html

  def show
    @product = Product.feed(current_user).find(params[:id])
    @user = @product.user
    commontator_thread_show(@product)
  end

  def like
    @product = Product.find(params[:id])
    @like = current_user.like! @product
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: @like }
    end
  end
end
