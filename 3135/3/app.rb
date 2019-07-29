require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require_relative 'helpers/utils'
#require 'pry'

set :database, "sqlite3:db/database.sqlite3"
enable :sessions

helpers Utils

before do
  @active_user = set_active_user(session[:id])

  pass if ['/login', '/logout', '/registration', '/add_review'].include? request.path_info
  session[:return_to_page] = request.path_info
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
  #make registration
  user = User.create(params)
  session[:id] = user[:id]
  redirect session[:return_to_page]
end

# login
get '/login' do
  erb :login_form
end

post '/login' do
  #redo login
  login(params[:email],params[:password])
end

get '/logout' do
  session[:id] = nil
  redirect session[:return_to_page]
end

# add_review
post '/add_review' do
  #redo review
  Review.create(params)
  redirect session[:return_to_page]
end

# restaurants_in_detail
get '/:name' do
  @restaurant = Restaurant.find_by(name: params[:name])
  erb :restaurant_in_detail
end

require './models/user'
require './models/restaurant'
require './models/review'

#binding.pry
