class Api::My::ProductsController < Api::ApplicationController
  before_filter :hard_authenticate!

  def index
    @products = @current_user.products.includes([:attachments, :category]).page(params[:page])
  end

  def create
  end
end
