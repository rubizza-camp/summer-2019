# require_relative 'base_controller'
class RestaurantsController < BaseController
  get '/restaurants' do
    @rests = Restaurant.all
    erb :'restaurants/index', layout: :layout
  end

  get '/restaurants/:id' do
    @rest = Restaurant.find(params[:id])
    erb :'restaurants/show', layout: :layout
  end
end
