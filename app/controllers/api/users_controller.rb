class Api::UsersController < Api::ApplicationController
  # before_filter :authenticate_user!, only: :edit

  def index
    if params[:q] || params[:term]
      q = "%#{params[:q] || params[:term]}%"
      @users = User.where{ name != nil }.where{ (name =~ q) | (nickname =~ q)}.limit(20)
    else
      @users = User.limit(20)
    end

    # render json: @users
  end

  def show
    @user = User.where(id: params[:id]).first!
  end

end
