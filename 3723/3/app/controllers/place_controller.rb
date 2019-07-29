class PlaceController < ApplicationController

  get '/' do
    @places = Place.all
    erb :'index'
  end

  get '/places/:id' do
    @place = Place.find_by_id(params[:id])
    erb :'places/show'
  end
end
