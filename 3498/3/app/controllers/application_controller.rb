require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require_relative '../models/user.rb'
require_relative '../models/place.rb'

set :database, "sqlite3:food-rating.sqlite3"

class ApplicationController < Sinatra::Base

  set :database, "sqlite3:food-rating.sqlite3"
  set :views, "app/views"

  configure do
    enable :sessions
  end

  get '/' do
  	#@user = User.find(session[:user_id])
    @places = Place.all
    erb :home
  end

  get '/signup' do
  	#@user = User.new
    erb :'/signup'
  end

  post '/registrations' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if params[:password].empty?
      @error = 'Enter password!'
      if @user.save
      	session[:user_id] = @user.id
      else
        @error = 'Error'
      end
    end
    redirect '/'
    #erb :home
  end

  get '/login' do
    #@anon = User.new
    erb :login
  end

  post '/login' do
    @user ||= User.find_by(email: params[:email])
    #@anon = User.new(params[:user])
    if @user
      if @user.password == params[:password]
        session['user_id'] = @user.id
        redirect '/'
      else
        @error = 'Wrong password'
      end
    else
      @error = 'Wrong e-mail'
    end
    erb :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
