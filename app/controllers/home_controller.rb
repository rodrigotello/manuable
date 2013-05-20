class HomeController < ApplicationController
  def index
    @products = Product.recently_created

    if user_signed_in?
      @products = @products.with_like(current_user).limit(50)
    end

    if params[:c].present?
      @products = @products.where(category_id: params[:c]).limit(50)
    end
  end
end
