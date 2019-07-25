class RestaurantsController < ApplicationController

  get '/' do
    @restaurants = Restaurant.all
    if logged_in?
      slim :'home/for_logged_in_users', :layout => :'layouts/home'
    else
      slim :'home/for_unregistered_users', :layout => :'layouts/home'
    end
  end

  get '/:id' do
    @restaurant = Restaurant.find_by(id: params[:id])
    unless @restaurant
      flash[:message] = 'This restautant is out of our scope'
      redirect '/'
    end
    if logged_in?
      slim :'restautant/for_logged_in_users', :layout => :'layouts/restautant'
    else
      slim :'restautant/for_unregistered_users', :layout => :'layouts/restautant'
    end
  end
end
