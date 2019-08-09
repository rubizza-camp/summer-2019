require_relative 'config/environment'

Dir['controllers/*.rb'].each { |file| require_relative file }

use Rack::Static, urls: ['/css'], root: 'public'
use Rack::MethodOverride

use CommentsController
use UsersController
run PlacesController
