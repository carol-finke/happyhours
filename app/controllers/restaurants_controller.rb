class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all

    if params[:neighborhoods].present?
      @restaurants = @restaurants.where(neighborhood: params[:neighborhoods])
    end

    if params[:days].present?
      @restaurants = @restaurants.select { |restaurant| params[:days].any? { |day| restaurant.send(day).present? } }
    end

    if params[:time].present?
      @restaurants = @restaurants.select do |restaurant|
        params[:days].any? do |day|
          happy_hour_time = restaurant.send(day)
          next unless happy_hour_time

          start_time, end_time = happy_hour_time.split('-').map { |t| Time.parse(t) }
          filter_time = Time.parse(params[:time])
          filter_time.between?(start_time, end_time)
        end
      end
    end
  end
end
