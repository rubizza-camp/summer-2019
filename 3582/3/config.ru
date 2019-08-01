require './config/environment'

use Rack::MethodOverride

use RestaurantsController
use CommentsController
use UsersController
run ApplicationController
