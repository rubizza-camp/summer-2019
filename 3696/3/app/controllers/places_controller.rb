# frozen_string_literal: true

require_relative 'base_controller'

class PlacesController < BaseController
  namespace '/places' do
    get '/:name' do
      @place = Place.find_by(name: params[:name])
      if @place
        erb :place
      else
        warning_message 'No such cafe!'
        redirect '/'
      end
    end
  end
end
