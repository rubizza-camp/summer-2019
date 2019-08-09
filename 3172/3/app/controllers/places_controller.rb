require_relative 'application_controller'

class PlacesController < ApplicationController
  get '/places/:id' do
    @place = Place.find(params[:id])
    @average_rating = @place.reviews.average('rating')
    @average_rating = @average_rating.round 2 if @average_rating
    erb :place
  end
end
