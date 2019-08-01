class RestaurantsController < ApplicationController
  get '/' do
    @restaurants = Restaurant.all
    if logged_in?
      slim :'home/for_logged_in_users', layout: :'layouts/home'
    else
      slim :'home/for_unregistered_users', layout: :'layouts/home'
    end
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @raiting = @restaurant.comments.average(:mark).round
    if logged_in?
      slim :'restaurant/for_logged_in_users', layout: :'layouts/restaurant'
    else
      slim :'home/for_unregistered_users', layout: :'layouts/restaurant'
    end
  end
end
