require 'sinatra'
require 'sinatra/activerecord'
#require 'pry'

set :database, "sqlite3:db/database.sqlite3"
enable :sessions

before do
  @logged_in = session[:id]
end

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
  user = User.create(params)
  redirect '/'
end

# login
get '/login' do
  erb :login_form, :layout => :layout
end

post '/login' do
  em = params[:email]
  pw = params[:password]
  if User.exists?(email: em) && User.find_by(email: em)[:password] == pw
    session[:id] = User.find_by(email: em)[:id]
    redirect '/'
  else
    'incorrent email - password combination'
  end
end

get '/logout' do
  session.clear
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
