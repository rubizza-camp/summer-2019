class RestaurantsController < ApplicationController
  get '/' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params['id'])
    @average_rating = @restaurant.comments.average(:rating).round
    erb :restaurant
  end

  post '/restaurants/:id' do
    @restaurant = Restaurant.find(params['id'])
    if current_user
      create_comment
    else
      redirect '/login'
    end
    erb :restaurant
  end
end
