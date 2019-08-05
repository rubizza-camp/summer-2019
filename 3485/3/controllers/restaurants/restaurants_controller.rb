class RestaurantsController < ApplicationController
  get '/' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments.includes(:user)
    @restaurant.update(raiting: @comments.average(:raiting))
    erb :restaurant_page
  end
end
