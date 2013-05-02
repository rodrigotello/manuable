class HomeController < ApplicationController
  def index
    if signed_in?
  	 @activities = PublicActivity::Activity.joins("LEFT OUTER JOIN likes ON likes.product_id = activities.trackable_id AND likes.user_id = #{current_user.id}")
                                            .select("activities.*, IFNULL(likes.id, 0) as liked")
                                            .order("created_at desc")
    else
      @activities = PublicActivity::Activity.order("created_at desc")
    end
  end

  def product
  	@product = Product.find(params[:id])
  end
end
