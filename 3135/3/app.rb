require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require_relative 'helpers/utils'
#require 'pry'

set :environment, :development
set :database, "sqlite3:db/database.sqlite3"
enable :sessions

helpers Utils

before do
  @active_user = set_active_user(session[:id])
end

# main page
get '/' do
  @restaurants = Restaurant.all
  erb :index
end

# registration
get '/registration' do
  erb :registration_form
end

post '/registration' do
  user = User.create(params)
  session[:id] = user[:id]
  redirect '/'
end

# login
get '/login' do
  erb :login_form
end

post '/login' do
  login(params[:email],params[:password])
end

get '/logout' do
  session.clear
  redirect '/'
end

# add_review
post '/add_review' do
  Review.create(params)
  redirect "/#{Restaurant.find(params[:restaurant_id])[:name]}"
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
