require 'digest/md5'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './controllers/places_controller'
require_relative './controllers/reviews_controller'
require_relative './controllers/users_controller'
require_relative './models/place'
require_relative './models/review'
require_relative './models/user'

set :database, adapter: 'sqlite3', database: 'places.sqlite3'
set views: proc { File.join(root, '../views/') }

class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'secret'
  end

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  use UsersController
  use ReviewsController
  use PlacesController

  get '/' do
    redirect '/places/'
  end
end
