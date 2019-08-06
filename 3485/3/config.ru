Dir.glob('./{models,controllers}/**/*.rb').each { |file| require file }

use Rack::MethodOverride
use RegistrationController
use CommentsController
use RestaurantsController
use Controller
set :database, adapter: 'sqlite3', database: 'restaurants.sqlite3'

map('/') { run ApplicationController}
