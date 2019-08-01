# frozen_string_literal: true

require_relative 'main_controller'

class PlacesController < MainController
  namespace '/places' do
    get '/:id' do
      @place = Place.find_by(id: params[:id])
      if @place
        erb :place
      else
        show_message 'No that place'
        redirect '/'
      end
    end
  end
end
