require 'bundler'
Bundler.require(:default, :development)
Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

set :database, {adapter: "sqlite3", database: "restaurantRating.sqlite3"}
use Rack::MethodOverride

map('/') { run UserController }
