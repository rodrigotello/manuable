class FollowingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find params[:id]
    @following = current_user.follow!(@user)

    respond_to do |format|
      format.json { render json: @following }
      format.html { redirect_to @user }
    end
  end

  def destroy
    @user = User.find params[:id]
    @following = current_user.unfollow!(@user)

    respond_to do |format|
      format.json { render json: true }
      format.html { redirect_to @user }
    end
  end
end
