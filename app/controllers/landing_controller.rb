class LandingController < ApplicationController
  def index
    user = User.where(:nickname => params[:id]).first
    redirect_to user and return if user.present?

    user = Event.incoming.where(:slug => params[:id]).first
    redirect_to event and return if user.present?

    redirect_to root_path
  end
end
