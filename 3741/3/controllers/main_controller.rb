# frozen_string_literal: true

require_relative 'sessions_controller'
require_relative 'places_controller'
require_relative 'reviews_controller'
require 'sinatra/flash'
require 'sinatra/namespace'
require 'truemail'
require_relative '../helpers/view_helper'
# main class
class MainController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'ranker'
    set views: proc { File.join(root, '../views/') }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  helpers ViewHelper

  get '/' do
    @places = Place.all
    erb :home
  end

  use SessionsController
  use PlacesController
  use ReviewsController
end
