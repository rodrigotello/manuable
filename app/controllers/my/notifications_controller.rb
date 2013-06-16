class My::NotificationsController < ApplicationController
  def update
  end

  def show
    @notification = current_user.notifications.find(params[:id])
    @notification.read!
    redirect_to @notification.product
  end
end
