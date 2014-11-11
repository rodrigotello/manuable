class SalesController < ApplicationController
  def dashboard
  	@sales = current_user.sales
  end
end
