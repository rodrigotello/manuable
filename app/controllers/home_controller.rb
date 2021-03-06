class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        @products = Product.filter(params).feed(current_user)
        @multipages = @products.count > 16
        @products = @products.limit(15)
      }
      format.js {
        @products = Product.filter(params).feed(current_user).offset((params[:page].to_i - 1) * 16).limit(16)
      }
      format.json {
        self.formats = [:html]
        render( json: {
                  html: render_to_string(partial: '/products/feed', locals: { products: @products, no_wrapper: true }, spacer_template: '/products/divider'),
                  total_entries: @products.total_count,
                  total_pages: @products.total_pages
                })
      }
    end
  end

  def about

  end

  def local
  end

end
