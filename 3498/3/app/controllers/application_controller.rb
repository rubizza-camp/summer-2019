require 'sinatra'
require 'sinatra/activerecord'
require_relative '../models/user.rb'
require_relative '../models/place.rb'

class ApplicationController < Sinatra::Base

  set :database, "sqlite3:food-rating.sqlite3"
  set :views, "app/views"

  get '/' do
    @places = Place.all
    erb :home
  end

  get '/registrations/signup' do
  	@user = User.new
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(params[:user])
    if params[:password].empty?
      @error = 'Enter password!'
    else
      @user.password = params[:password]
      if @user.save
      	session[:user_id] = @user.id
        redirect :home
      else
        @error = @user.errors.full_messages.first
      end
    end
    erb :home
  end

end
