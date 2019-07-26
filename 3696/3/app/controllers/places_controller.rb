# frozen_string_literal: true

require_relative 'base_controller'

class PlacesController < BaseController
  get '/' do
    @places = Place.all
    erb :home
  end

  get '/:name' do
    @place = Place.find_by(name: params[:name])
    if @place
      register_place @place.name
      erb :place
    else
      warning_message 'No such cafe!'
      redirect '/'
    end
  end
end
