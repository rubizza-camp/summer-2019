# frozen_string_literal: true

require_relative 'base_controller'

class RestaurantController < BaseController
  get '/:name' do
    @restaurant = Restaurant.find_by_name!(params[:name])
    session[:restaurant_id] = @restaurant.id
    erb :'/restaurants/restaurant'
  end
end
