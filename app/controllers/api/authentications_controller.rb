class Api::AuthenticationsController < Api::ApplicationController

  def create
    @user = User.where(email: params[:email]).first

    if @user && @user.valid_password?(params[:password])
      unless @access_token = @user.access_tokens.valid.first
        @access_token = @user.access_tokens.create
      end
    end
  end

end
