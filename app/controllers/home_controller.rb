class HomeController < ApplicationController
  def index
  	@products = Product.all
  end

  def product
  	@product = Product.find(params[:id])
  end
end
