class Api::My::ProfilesController < Api::ApplicationController
  before_filter :hard_authenticate!

  def update
    @current_user.update_attributes params.permit(:name, :email, :nickname, :avatar, :about, :cover, :city_id, :state_id, :zip_code, :about, :address, :birthday)
  end
end
