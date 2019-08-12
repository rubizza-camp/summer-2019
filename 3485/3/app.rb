require_relative 'app/models/restaurant'
require_relative 'app/models/user'
require_relative 'app/models/comment'

set :database, adapter: 'sqlite3', database: 'restaurants.sqlite3'
