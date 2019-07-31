require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'
require 'bcrypt'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

set :database, 'sqlite3:project-name.sqlite3'

get '/logout' do
  session.clear
  redirect '/'
end

get '/' do
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    @locations = Location.all
    @users = User.all
    erb :index
  else
    redirect '/login'
  end
end

get '/hey' do
  @session = session[:user_id]
  erb :hey
end

get '/location/:id' do
  @location = Location.find(params[:id])
  erb :location
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.new(username: params[:username], email: params[:email], password: params[:password])

  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/failure'
  end
end

get '/failure' do
  erb :failure
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user&.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/wrong'
  end
end

get '/login' do
  erb :login
end

# def hash_password(password)
#   BCrypt::Password.create(password).to_s
# end
#
# def test_password(password, hash)
#   BCrypt::Password.new(hash) == password
# end
