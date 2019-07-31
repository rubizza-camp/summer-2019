require_relative '../controllers/application_controller'

class PlacesController < ApplicationController
  get '/' do
    redirect '/places'
  end

  get '/places' do
    @places = Place.all
    erb :'places/index'
  end

  get '/place/:id' do
    @place = Place.find(params['id'])
    @comments = @place.comments
    @users = @comments.map(&:user)
    erb :'places/show'
  end
end
