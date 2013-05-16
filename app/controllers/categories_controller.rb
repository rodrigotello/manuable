class CategoriesController < ApplicationController
  def show
    if user_signed_in?
      @activities = Product.where(category_id: params[:id])
                            .collect(&:activities).flatten

    else
      @activities = PublicActivity::Activity.order("created_at desc")
    end
  end
end
