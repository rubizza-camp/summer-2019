require './app'
require '../controllers/application_controller'
require '../controllers/user_controller'
require '../controllers/locations_controller'

run ApplicationController
use UsersController
use LocationsController
