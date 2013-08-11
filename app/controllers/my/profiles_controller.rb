module My
  class ProfilesController < ApplicationController
    before_filter :authenticate_user!

    layout 'my'

    def show
      @my_section = "profile"
    end

    def edit
      case params[:f]
      when 's'
        @my_section = "name"
      when 'p'
        @my_section = 'password'
      when 'a'
        @my_section = 'picture'
      end
    end

    def update
      @user = current_user
      if params[:password].present? && params[:password_confirmation].present? && params[:current_password].present?
        current_user.update_with_password params[:user]
      else
        params[:user].delete :password
        params[:user].delete :password_confirmation
        params[:user].delete :current_password
        current_user.update_attributes params[:user]
      end
      sign_in @user, :bypass => true
      redirect_to :back, notice: 'Actualizado'
    end
  end
end
