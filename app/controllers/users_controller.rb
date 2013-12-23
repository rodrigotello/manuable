class UsersController < ApplicationController
  # before_filter :authenticate_user!, only: :edit

  def index
    if params[:q] || params[:term]
      q = "%#{params[:q] || params[:term]}%"
      @users = User.where{ name != nil }.where{ (name =~ q) | (nickname =~ q)}.limit(20)
    else
      @users = User.limit(20)
    end

    render json: @users
  end

  def show
    uid = params[:id]
    @user = User.where{ ( id == uid) | (nickname == uid.to_s) }.first

    raise ActiveRecord::RecordNotFound unless @user.present?

    @products = Product.feed(current_user).page( params[:page] ).per( params[:per_page] || 5 )

    if params[:f] == 'l'
      @products = @products.where(id: @user.liked_product_ids)
    #elsif params[:f] == 'p'
      #user_ids = @user.followee_ids+[@user.id]
      #liked_product_ids = @user.liked_product_ids
      #@products = @products.where{ (user_id >> user_ids) | (id >> liked_product_ids)}
    else
      @products = @products.where(user_id: @user.id)
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

end
