class Api::CategoriesController < Api::ApplicationController
  def index
    render json: { status: 200, categories: Category.all }
  end
end
