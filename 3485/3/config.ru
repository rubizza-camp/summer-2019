ENV['SINATRA_ENV'] ||= 'development'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require_all 'app'

Dir.glob('./{models,controllers,services}/**/*.rb').each { |file| require file }

use Rack::MethodOverride
use SessionController
use RegistrationController
use CommentsController
use RestaurantsController
set :database, adapter: 'sqlite3', database: 'restaurants.sqlite3'

map('/') { run ApplicationController }
