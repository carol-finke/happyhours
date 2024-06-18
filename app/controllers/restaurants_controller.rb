class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all

    # Filter by neighborhoods
    if params[:neighborhoods].present?
      @restaurants = @restaurants.where(neighborhood: params[:neighborhoods])
    end

    # Filter by days
    if params[:days].present?
      @restaurants = @restaurants.select do |restaurant|
        params[:days].any? { |day| restaurant.send(day).present? }
      end
    end

    # Filter by time
    if params[:time].present? && params[:days].present?
      filter_time = Time.parse(params[:time])
      @restaurants = @restaurants.select do |restaurant|
        params[:days].any? do |day|
          happy_hour_time = restaurant.send(day)
          next unless happy_hour_time

          start_time, end_time = happy_hour_time.split('-').map { |t| Time.parse(t) }
          filter_time.between?(start_time, end_time)
        end
      end
    end
  end
end
