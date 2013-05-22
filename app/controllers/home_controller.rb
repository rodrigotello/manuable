class HomeController < ApplicationController
  def index
    @products = Product.feed(current_user).page( params[:page] ).per( params[:per_page] || 5 )

    # if user_signed_in?
    #   @products = @products.with_like(current_user).limit(50)
    # end

    if params[:c].present?
      @products = @products.where(category_id: params[:c])
    end
    respond_to do |format|
      format.html {}
      format.json {
        self.formats = [:html]
        render( json: {
                  html: render_to_string(partial: '/products/feed', locals: { products: @products }),
                  total_entries: @products.total_count,
                  total_pages: @products.total_pages
                })
      }
    end
  end
end
