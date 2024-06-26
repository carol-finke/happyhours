class PagesController < ApplicationController
  def home
    @restaurants = Restaurant.distinct
  end

  def happy_hours
    @restaurants = Restaurant.distinct

    if params[:neighborhoods].present?
      @restaurants = @restaurants.where(neighborhood: params[:neighborhoods])
    end

    if params[:days].present?
      day_conditions = params[:days].map { |day| "#{day} IS NOT NULL AND #{day} != ''" }.join(' OR ')
      @restaurants = @restaurants.where(day_conditions)
    end

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

    Rails.logger.debug("Loaded #{@restaurants.count} restaurants")
  end
end
