require_relative '../helpers/auth'

class PlacesController < Sinatra::Base
  include AuthHelper

  register Sinatra::Flash

  configure do
    set :views, (proc { File.join(root, '../views/places') })
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
    Place.create(place_params)
    redirect '/places/'
  end

  private

  def place_params
    param_arr = %i[name note description longitude latitude]
    Hash[param_arr.collect { |name| [name, params[name.to_s]] }]
  end
end
