require 'sinatra/flash'
require 'sinatra/reloader'
require 'sinatra/session'
require './config/environment'
require_relative 'users_controller'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
  end

  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  get '/' do
    @places = Place.all
    erb :index
  end
end
