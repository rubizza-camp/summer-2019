require_relative 'config/environment'
require_relative 'app/controllers/application_controller'

use Rack::Static, urls: ['/css'], root: 'public' # Rack fix allows seeing the css folder.

# if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
# end

require_relative 'app/controllers/users_controller.rb'
require_relative 'app/controllers/places_controller.rb'
require_relative 'app/controllers/reviews_controller.rb'

use UsersController
use PlacesController
use ReviewsController

run ApplicationController
