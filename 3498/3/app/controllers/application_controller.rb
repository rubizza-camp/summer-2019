require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require_relative '../models/user.rb'
require_relative '../models/place.rb'
require_relative '../models/comment.rb'
require_relative '../helpers/place_helper.rb'
require_relative 'place_controller.rb'

set :database, 'sqlite3:food-rating.sqlite3'

class ApplicationController < Sinatra::Base
  set :database, 'sqlite3:food-rating.sqlite3'
  set :views, 'app/views'

  use PlaceController
  include PlaceHelper

  configure do
    enable :sessions
  end

  get '/' do
    @places = Place.all
    erb :home
  end

  get '/signup' do
    erb :'/signup'
  end

  post '/registrations' do
    @user = User.new(name: params[:username], email: params[:email], password: params[:password])
    params[:password] ? @user.save : @error = 'Enter password!'
    session[:user_id] = @user.id
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user
      if @user.password == params[:password]
        session[:user_id] = @user.id
      else
        @error = 'Wrong password'
      end
    else
      @error = 'Wrong e-mail'
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
