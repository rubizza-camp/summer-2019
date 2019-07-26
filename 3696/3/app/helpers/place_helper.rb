require 'sinatra/base'

class PlaceHelper < Sinatra::Base
  module Helpers
    def register_place(place)
      session[:place] = place
    end
  end

  helpers Helpers
end
