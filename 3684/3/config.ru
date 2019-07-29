Dir.glob('./{models,controllers}/*.rb').each { |file| require file }

use Rack::MethodOverride

set :database, adapter: 'sqlite3', database: 'restaurants.sqlite3'

map('/') { run Controller }
