require_relative 'base_controller'

class PlacesController < BaseController
  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :'places/show'
  end
end
