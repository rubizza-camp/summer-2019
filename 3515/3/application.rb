require 'sinatra/activerecord'
require 'sinatra'
require 'pundit'
require 'pry'
require 'bcrypt'
require_relative 'models/models'

set :database_file, 'db/config/database.yml'
enable :sessions

get '/' do
  erb :home
end

get '/user/singup' do
  erb :'/user/singup'
end

get '/user/singin' do
  erb :'/user/login'
end

get '/user/home_user' do
  erb :'/user/home_user'
end

get '/user/logout' do
  session.delete(:name)
  session.delete(:user_id)
  redirect '/'
end

get '/user/already_registered' do
  erb :'/user/already_registered'
end

get '/user/login_failed' do
  erb :'/user/login_failed'
end

post '/user/singup' do
  if User.find_by(email: params[:email])
    redirect '/user/already_registered'
  else
    user = User.create(name: params[:name], email: params[:email],
                       password: BCrypt::Password.create(params[:password]))
    session[:user_id] = user.id
    session[:name] = user.name
    redirect '/user/home_user'
  end
  end

post '/user/singin' do
  user = User.find_by(email: params[:email])
  if BCrypt::Password.new(user.password) == params[:password]
    session[:user_id] = user.id
    session[:name] = user.name
    redirect '/user/home_user'
  else
    redirect '/user/login_failed'
  end
end



# Restaurant.find_by(id:1).name
# Restaurant.all.first.attributes.values
# Restaurant.all.first.read_attribute(:name)
