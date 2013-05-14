class FollowingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find params[:user_id]
    render json: current_user.follow_to!(@user) and return
    head :ok
  end
end
