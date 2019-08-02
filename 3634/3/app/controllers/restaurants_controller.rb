require 'pry'

class RestaurantsController < ApplicationController
  get '/' do
    @restaurants = Restaurant.all
    slim :'restaurants/index.html', layout: :'layouts/application.html'
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments.includes(:user)
    @raiting = @restaurant.comments.average(:mark)
    slim :'restaurants/show.html', layout: :'layouts/application.html'
  end
end
