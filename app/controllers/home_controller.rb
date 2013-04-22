class HomeController < ApplicationController
  def index
  	@activities = PublicActivity::Activity.order("created_at desc")
  end

  def product
  	@product = Product.find(params[:id])
  end
end
