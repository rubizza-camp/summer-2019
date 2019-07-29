require 'sinatra'
require 'sinatra/activerecord'
require_relative './controllers/places_controller'
require_relative './controllers/reviews_controller'
require_relative './controllers/users_controller'
require_relative './models/place'
require_relative './models/review'
require_relative './models/user'

set :database,  adapter: 'sqlite3', database: 'places.sqlite3'
set views: proc { File.join(root, '../views/') }
enable :sessions

class App < Sinatra::Base
  use UsersController
  use ReviewsController
  use PlacesController

  register Sinatra::ActiveRecordExtension

  get '/' do
    redirect '/places/'
  end
end
