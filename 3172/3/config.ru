require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/users_controller.rb'
require_relative 'app/controllers/places_controller.rb'
require_relative 'app/controllers/reviews_controller.rb'
require_relative 'app/controllers/sessions_controller.rb'
require_relative 'app/controllers/registrations_controller.rb'

use UsersController
use PlacesController
use ReviewsController
use UsersController
use RegistrationsController
use SessionsController

run ApplicationController
