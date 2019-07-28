require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

set :database, "sqlite3:db/database.sqlite3"

get '/' do
  'Hello world!'
end

require './models/user'
require './models/restaurant'
require './models/review'

binding.pry
