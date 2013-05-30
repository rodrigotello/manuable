class ProductsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html

  def like
    @product = Product.find(params[:id])
    @like = current_user.like! @product
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: @like }
    end
  end

end
