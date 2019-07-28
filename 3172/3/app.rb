require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:db/flamp.db'

class Place < ActiveRecord::Base
end

class User < ActiveRecord::Base
end

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

get '/' do
  @places = Place.all
  erb :index
end

get '/login/sign_up' do
  erb :login_sign_up
end

post '/login/attempt' do
  hh = { user_name: 'Enter user name',
         email:     'Enter email',
         password:  'Enter password' }

  @error = hh.select { |key| params[key] == '' }.values.join(', ')
  return erb :login_sign_up if @error != ''

  user = User.find_by name: params[:user_name]
  @error = 'Username is busy' if user
  return erb :login_sign_up if @error != ''

  email = User.find_by email: params[:email]
  @error = 'E-mail is busy' if email
  return erb :login_sign_up if @error != ''

  session[:identity] = params['user_name']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/place/:id' do
  @place = Place.find(params[:id])
  @message = session[:message]
  erb :place
end
