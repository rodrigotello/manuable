class Api::FollowingsController < Api::ApplicationController
  before_filter :find_user
  before_filter :hard_authenticate!

  def create
    @following = current_user.follow!(@user)
  end

  def destroy
    @following = current_user.unfollow!(@user)
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
