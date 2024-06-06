class PagesController < ApplicationController
  def home
  end

  def happy_hours
    @restaurants = Restaurant.where(restaurant_type: 'happy_hour')
  end

  def patios
    @restaurants = Restaurant.where(restaurant_type: 'patio')
  end

  def rooftops
    @restaurants = Restaurant.where(restaurant_type: 'rooftop')
  end
end
