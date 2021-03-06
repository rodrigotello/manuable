module My
  class ProfilesController < ApplicationController
    before_filter :authenticate_user!

    layout 'my'

    def show
      render action: :edit
    end

    def edit
      @my_section = params[:f]
      @premium_user = PremiumUser.where(premium_user: current_user.id)[0].nil? ? false : true
    end

    def update
      @user = current_user
      if params[:password].present? && params[:password_confirmation].present? && params[:current_password].present?
        if current_user.update_with_password user_params
          sign_in @user, :bypass => true
          redirect_to :back, notice: 'Actualizado'
        else
          @my_section = "p"
          render action: :edit
        end
      else
        params[:user].delete :password
        params[:user].delete :password_confirmation
        params[:user].delete :current_password
        if current_user.update_attributes user_params
          sign_in @user, :bypass => true
          redirect_to :back, notice: 'Actualizado'
        else
          @my_section = "s"
          render action: :edit
        end
      end

    end

    protected

    def user_params
      params.require(:user).permit(:password, :password_confirmation, :remember_me, :avatar, :cover, :remote_cover_url, :name, :nickname, :remote_avatar_url, :city_id, :state_id, :address, :zipcode, :occupation, :about, :birthday, :nickname).tap do |h|
        h[:email] = params[:user][:email] if current_user.email.include?('manuablefakeemail')
      end
    end
  end
end
