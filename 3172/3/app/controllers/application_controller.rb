require 'sinatra/reloader'
require 'sinatra/session'
require './config/environment'
require_relative 'users_controller'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
  end

  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  get '/' do
    @places = Place.all
    erb :index
  end
end
