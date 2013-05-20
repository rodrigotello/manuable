class UsersController < ApplicationController
  load_and_authorize_resource
  # before_filter :authenticate_user!, only: :edit

  def show
    # redirect_to root_path and return unless session[:beta].present?
    @products = Product.recently_created.limit(50)

    if user_signed_in?
      if params[:f] == 'l'
        @products = @products.with_like(current_user)
                             .where(id: @user.liked_product_ids)

      elsif params[:f] == 'p'
        @products = @products.with_like(current_user)
                             .where(user_id: @user.id)
      else
        @products = @products.with_like(current_user)
                             .where(user_id: @user.followee_ids+[@user.id])
      end
    end
  end

  def update
  end
end
