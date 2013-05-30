class UsersController < ApplicationController
  load_and_authorize_resource
  # before_filter :authenticate_user!, only: :edit

  def show
    # redirect_to root_path and return unless session[:beta].present?
    # @products = Product.recently_created.limit(50)

    @products = Product.feed(current_user).page( params[:page] ).per( params[:per_page] || 3 )

    if user_signed_in?
      if params[:f] == 'l'
        @products = @products.where(id: @user.liked_product_ids)
      elsif params[:f] == 'p'
        @products = @products.where(user_id: @user.id)
      else
        @products = @products.where(user_id: @user.followee_ids+[@user.id])
      end
    end

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

  def update
  end
end
