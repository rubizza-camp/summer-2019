require 'bundler/setup'
Bundler.require

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/flamp.db'
)

require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/places_controller'
require_relative '../app/controllers/reviews_controller'
require_relative '../app/models/place'
require_relative '../app/models/review'
require_relative '../app/models/user'
