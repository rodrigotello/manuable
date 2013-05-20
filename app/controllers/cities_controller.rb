class CitiesController < ApplicationController
  respond_to :json

  def index

    if params[:q].present? && params[:state_id].present?
      query = params[:q]
      @cities = City.joins(:state).where{ (name =~ "%#{query}%")  }
                    .select("cities.id, cities.name, states.name AS state_name, states.id AS sid")
                    .where(state_id: params[:state_id])
                    .limit(30)
    else
      @cities = []
    end

    respond_with @cities
  end
end
