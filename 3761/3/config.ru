require_relative './config/environment'

use Rack::MethodOverride
use UserController
use PlaceController
use ReviewController
run ApplicationController
