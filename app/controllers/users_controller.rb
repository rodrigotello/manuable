class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, only: :edit

  def show

  end

  def edit

  end

  def update
  end
end
