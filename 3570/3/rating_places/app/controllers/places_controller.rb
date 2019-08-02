require_relative 'application_controller'

class PlacesController < ApplicationController
  get '/places' do
    @places = Place.all
    erb :home
  end

  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :'places/show'
  end
end
