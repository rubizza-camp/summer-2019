require_relative 'application_controller'

class PlacesController < ApplicationController
  set :views, File.realpath('./views/places')

  before do
    redirect '/' unless login?
  end

  get '/places' do
    @places = Place.all
    haml :index
  end

  get '/places/:id' do
    @place = Place.find(params['id'])
    haml :show
  end
end
