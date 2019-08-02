require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require_relative '../models/user.rb'
require_relative '../models/place.rb'
require_relative '../models/comment.rb'
require_relative '../helpers/users_helper.rb'
require_relative '../helpers/places_helper.rb'
require_relative 'users_controller.rb'
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
