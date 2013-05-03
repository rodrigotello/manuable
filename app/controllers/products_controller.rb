class ProductsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html

  def like
    @product = Product.find(params[:id])
    @like = @product.like! current_user
    respond_to do |format|
      format.html { }
      format.json { render json: @like }
    end
  end

end
