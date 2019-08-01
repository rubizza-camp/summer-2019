# frozen_string_literal: true

require_relative 'base_controller'

class RestaurantController < BaseController
  get '/:name' do
    @restaurant = Restaurant.find_by_name!(params[:name])
    erb :'/restaurants/restaurant'
  end
end
