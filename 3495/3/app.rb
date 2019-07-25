require_relative './models/user'
require_relative './models/review'
require_relative './models/restaurant'

set :port, 1337
set :database, {adapter: "sqlite3", database: "restaurantRating.sqlite3"}