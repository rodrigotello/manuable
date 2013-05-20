class HomeController < ApplicationController
  def index
    @products = Product.recently_created

    if user_signed_in?
      @products = @products.with_like(current_user)
    end

    if params[:c].present?
      @products = @products.where(category_id: params[:c])
    end
  end
end
