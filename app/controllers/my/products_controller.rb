class My::ProductsController < ApplicationController
  layout 'my'

  def new
    @my_section = "new_product"
    @product = Product.new
  end

  def index
    @my_section = "products"
    @products = current_user.products
  end
end
