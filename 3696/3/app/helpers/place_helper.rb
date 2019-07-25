require 'sinatra/base'

module Sinatra
  module PlaceHelper
    def register_place(place)
      session[:place] = place
    end
  end

  helpers PlaceHelper
end
