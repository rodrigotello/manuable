class UsersController < ApplicationController
  load_and_authorize_resource
  # before_filter :authenticate_user!, only: :edit

  def show
    redirect_to root_path and return unless session[:beta].present?
    if user_signed_in?
      if params[:f] == 'l'
        @activities = PublicActivity::Activity.joins("LEFT OUTER JOIN likes ON likes.product_id = activities.trackable_id AND likes.user_id = #{current_user.id}")
                                              .select("activities.*, coalesce(likes.id, 0) AS liked")
                                              .where(trackable_type: 'Product', trackable_id: @user.liked_product_ids)
                                              .order("created_at desc")
      elsif params[:f] == 'p'
        @activities = PublicActivity::Activity.joins("LEFT OUTER JOIN likes ON likes.product_id = activities.trackable_id AND likes.user_id = #{current_user.id}")
                                              .select("activities.*, coalesce(likes.id, 0) AS liked")
                                              .where(owner_type: 'User', owner_id: @user.id)
                                              .order("created_at desc")
      else
        @activities = PublicActivity::Activity.joins("LEFT OUTER JOIN likes ON likes.product_id = activities.trackable_id AND likes.user_id = #{current_user.id}")
                                              .select("activities.*, coalesce(likes.id, 0) AS liked")
                                              .where(owner_type: 'User', owner_id: @user.followee_ids+[@user.id])
                                              .order("created_at desc")
      end
    else
      @activities = PublicActivity::Activity.order("created_at desc")
    end
  end

  def update
  end
end
