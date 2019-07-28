require_relative 'base_controller'
require 'pry'
class RestaurantController < BaseController
  get '/:name' do
    @restaurant = Restaurant.find_by_name!(params[:name])
    register_restaurant(@restaurant.name)
    erb :restaurant
  end

  def register_restaurant(restaurant)
    session[:restaurant] = restaurant
  end
end
