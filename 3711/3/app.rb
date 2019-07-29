# require 'rack-flash'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require_relative './controllers/places_controller'
require_relative './controllers/reviews_controller'
require_relative './controllers/users_controller'
require_relative './models/place'
require_relative './models/review'
require_relative './models/user'

set :database,  adapter: 'sqlite3', database: 'places.sqlite3'
set views: proc { File.join(root, '../views/') }

class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'secret'
  end

  use UsersController
  use ReviewsController
  use PlacesController

  register Sinatra::ActiveRecordExtension

  get '/' do
    redirect '/places/'
  end
end
