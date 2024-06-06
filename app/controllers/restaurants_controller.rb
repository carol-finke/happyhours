class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all

    if params[:sort].present?
      case params[:sort]
      when 'neighborhood'
        @restaurants = @restaurants.order(:neighborhood)
      when 'price'
        @restaurants = @restaurants.order(:price)
      when 'day'
        @restaurants = @restaurants.order(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
      end
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
