require_relative '../decorators/restaurant_decorator.rb'
class RestaurantsController < BaseController
  get '/' do
    @restaurants = Restaurant.all
    @restaurants.map { |rest| rest.extend(RestaurantDecorator) }
    erb :'restaurants/index'
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @restaurant.extend(RestaurantDecorator)
    @current_user = User.find(session[:user_id]) if session[:user_id]
    @reviews = @restaurant.reviews.includes(:user)
    erb :'restaurants/show'
  end
end
