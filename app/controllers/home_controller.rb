class HomeController < ApplicationController
  def index
    @products = Product.filter(params).feed(current_user).page( params[:page] ).per( params[:per_page] || 12 )

    respond_to do |format|
      format.html {}
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
end
