class FollowingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find params[:user_id]
    @following = current_user.follow_to!(@user)

    respond_to do |format|
      format.json { render json: @following }
      format.html { redirect_to @user }
    end
  end
end
