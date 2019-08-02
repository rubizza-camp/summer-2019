class PlaceController < ApplicationController
  get '/' do
    # require 'pry'; binding.pry
    @places = Place.all
    erb :index
  end

  get '/places/:id' do
    @place = Place.find(params[:id])
    @reviews = @place.reviews.reverse
    @average_score = @place.reviews.average(:grade).to_f.truncate(1)
    flash[:error] = I18n.t(:unregistered_user) unless session?
    erb :place
  end
end
