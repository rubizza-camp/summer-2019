require 'sinatra'
require 'sinatra/activerecord'
#require 'pry'

set :database, "sqlite3:db/database.sqlite3"

get '/' do
  @restaurants = Restaurant.all
  erb :index, :layout => :layout
end

require './models/user'
require './models/restaurant'
require './models/review'

#binding.pry
