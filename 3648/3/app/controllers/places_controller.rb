class PlacesContoller < ApplicationController
  get '/' do
    @places = Place.all
    erb :home
  end

  get '/place/:id' do
    @place = Place.find_by_id(params[:id])
    erb :place
  end
end
