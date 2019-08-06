require './config/enviroment.rb'

enable :sessions

use ApplicationController
use UsersController
use PlacesController
run ApplicationController
