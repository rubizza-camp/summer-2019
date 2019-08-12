class PlaceController < ApplicationController
  get '/' do
    @places = Place.all
    erb :index
  end

  get '/places/:id' do
    @place = Place.find(params[:id])
    @reviews = @place.reviews.order(id: :desc)
    @average_score = @place.reviews.average(:grade).to_f.round(2)
    flash[:error] = I18n.t(:unregistered_user) unless session?
    erb :place
  end
end
