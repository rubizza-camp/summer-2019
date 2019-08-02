require 'sinatra'
require 'bcrypt'
require_relative 'places_controller.rb'

class ApplicationController < Sinatra::Base
  set :database, ENV['DB_PATH']
  set :views, 'app/views'

  use UsersController
  use PlacesController

  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
  end
end
