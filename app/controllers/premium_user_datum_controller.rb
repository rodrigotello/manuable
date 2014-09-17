class PremiumUserDatumController < ApplicationController

  def show
  	@account = current_user.premium_user_data
  end

  def new
  	@account = current_user.premium_user_data
  end

  def create
  end

  def delete
  end

  def edit
   @account = current_user.premium_user_data
  end

  def update
  	@account = current_user.premium_user_data
  	#if @account.update_attributes(params[:premium_user_data])
  	if @account.update_attributes(data_params)
  		redirect_to current_user
  	else
  		redirect_to edit_premium_user_datum_path(@account)
  	end
  end

  def index
  end

  private

  def data_params
  	params.require(:premium_user_data).permit(:account_owner, :bank_account, :clabe, :bank_name, :rfc)
  end

end

