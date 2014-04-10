class Api::CategoriesController < Api::ApplicationController
  def index
    render json: Category.all
  end
end
