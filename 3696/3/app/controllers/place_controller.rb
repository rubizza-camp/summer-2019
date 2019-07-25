# frozen_string_literal: true

require_relative '../helpers/info_helper'
require_relative '../helpers/place_helper'
require_relative '../helpers/auth_helper'

class PlaceController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  helpers Sinatra::InfoHelper
  helpers Sinatra::PlaceHelper
  helpers Sinatra::AuthHelper

  get '/' do
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
