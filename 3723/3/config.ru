require_relative './config/environment'

use Rack::MethodOverride
use PlaceController
use UserController
run ApplicationController
