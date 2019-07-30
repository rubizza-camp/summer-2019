require_relative './config/environment'
Tilt.register Tilt::ERBTemplate, 'html.erb'

use Rack::MethodOverride

use RestaurantsController
use UsersController

run ApplicationController
