require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:db/database.sqlite3"

get '/' do
  'Hello world!'
end

require ./models
