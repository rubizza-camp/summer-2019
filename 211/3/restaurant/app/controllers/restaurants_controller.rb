class RestaurantsController < BaseController
  get '/' do
    @rests = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/:id' do
    @rest = Restaurant.find(params[:id])
    erb :'restaurants/show'
  end
end
