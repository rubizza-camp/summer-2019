require_relative 'application_controller.rb'

class PlacesController < ApplicationController
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
