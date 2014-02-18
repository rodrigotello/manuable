class Api::AuthenticationsController < Api::ApplicationController
  skip_before_filter :authenticate!

  def create
    @user = User.where(email: params[:email]).first!

    if @user.valid_password?(params[:password])
      unless @access_token = @user.access_tokens.valid.first
        @access_token = @user.access_tokens.create
      end
    end
  end

end