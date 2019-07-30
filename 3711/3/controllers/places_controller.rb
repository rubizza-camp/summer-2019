require_relative '../helpers/auth'
require_relative '../helpers/crypt'

class PlacesController < Sinatra::Base
  include AuthHelper
  include CryptHelper

  register Sinatra::Flash

  configure do
    set :views, proc { File.join(root, '../views/places') }
  end

  get '/places/' do
    @places = Place.all
    erb :main
  end

  get '/places/new' do
    erb :new
  end

  get '/places/:id' do
    @place_id = params['id']
    erb :index
  end

  post '/places/new' do
    Place.create(name: params['name'], note: params['note'], description: params['descr'],
                 longitude: params['longit'], latitude: params['latit'])
    redirect '/places'
  end
end
