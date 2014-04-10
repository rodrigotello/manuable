class Api::CommentsController < Api::ApplicationController
  def index
    @comments = Product.find(params[:id]).comments.includes(:creator)
  end
end
