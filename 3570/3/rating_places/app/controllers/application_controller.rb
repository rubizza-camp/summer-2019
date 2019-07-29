# frozen_string_literal: true

require_relative '../helpers/session_helper'
require_relative 'comments_controller'
require_relative 'places_controller'
require_relative 'users_controller'
require_relative 'sessions_controller'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
  end

  use CommentsController
  use PlacesController
  use UsersController
  use SessionsController

  helpers SessionHelper

  get '/' do
    @places = Place.all
    erb :home
  end
end
