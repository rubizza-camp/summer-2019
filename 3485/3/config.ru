require_relative './config/environment'

Dir.glob('./{models,controllers,services}/**/*.rb').each { |file| require file }

use Rack::MethodOverride
use SessionController
use RegistrationController
use CommentsController
use RestaurantsController
set :database, adapter: 'sqlite3', database: 'restaurants.sqlite3'

map('/') { run ApplicationController }
