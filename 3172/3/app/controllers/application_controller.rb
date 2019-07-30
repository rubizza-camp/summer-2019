require 'sinatra/flash'
require 'sinatra/namespace'
require './config/environment'
require_relative 'users_controller'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :views, 'app/views'
  end

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  get '/' do
    @places = Place.all
    erb :index
  end
end
