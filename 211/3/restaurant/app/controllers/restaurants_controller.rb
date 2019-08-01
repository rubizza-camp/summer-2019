require_relative '../decorators/restaurant_decorator.rb'
class RestaurantsController < BaseController
  get '/' do
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @restaurant.extend(RestaurantDecorator)
    erb :'restaurants/show'
  end
end
