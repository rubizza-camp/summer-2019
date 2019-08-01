class RestaurantsController < ApplicationController
  get '/restaurants/:id' do
    id = params[:id].to_i - 1
    @restaurant = Restaurant.all[id]
    @comments = @restaurant.comments
    @rating = @comments.any? ? @comments.average(:rating).truncate(1) : I18n.t(:null_rating)
    erb :restaurant
  end
end
