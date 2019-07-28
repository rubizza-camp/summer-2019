require 'sinatra'
require 'sinatra/activerecord'
#require 'pry'

set :database, "sqlite3:db/database.sqlite3"

# main page
get '/' do
  @restaurants = Restaurant.all
  erb :index, :layout => :layout
end

# registration
get '/registration' do
  erb :registration_form, :layout => :layout
end

post '/registration' do
  User.create(params)
  redirect '/'
end

# restaurants_in_detail
get '/:name' do
  @restaurant = Restaurant.find_by(name: params[:name])
  erb :restaurant_in_detail, :layout => :layout
end

require './models/user'
require './models/restaurant'
require './models/review'

#binding.pry
