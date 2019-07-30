class PlacesController < ApplicationController
  get '/places' do
    @places = Place.all
    erb :'/index'
  end

  get '/place/:id' do
    @place = Place.find(params['id'])
    @comments = @place.comments
    @users = @comments.map(&:user)
    erb :'/show'
  end
end