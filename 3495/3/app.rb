require_relative './models/user'
require_relative './models/review'
require_relative './models/restaurant'
require 'bundler'
Bundler.require(:default, :development)

set :port, 1337
set :database, {adapter: "sqlite3", database: "restaurantRating.sqlite3"}