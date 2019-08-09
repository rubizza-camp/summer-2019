class RestaurantsController < ApplicationController
  before '/restaurants/:id' do
    redirect '404' unless Restaurant.exists?(params[:id])
  end
  get '/' do
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments.includes(:user)
    erb :'restaurants/restaurant'
  end
end
