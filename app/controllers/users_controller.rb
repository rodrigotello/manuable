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
    @products = Product.feed(current_user).page( params[:page] ).per( params[:per_page] || 12 )

    if params[:f] == 'l'
      @products = @products.where(id: @user.liked_product_ids)
    else
      @products = @products.where(user_id: @user.id)
    end

    @multipages = @products.total_pages > 1

    respond_to do |format|
      format.html {}
      format.js   {}
    end
  end

end
