Dir.glob('./{models,controllers}/*.rb').each { |file| require file }

use Rack::MethodOverride

set :database, adapter: 'sqlite3', database: '3.sqlite3'

map('/') { run Controller }
