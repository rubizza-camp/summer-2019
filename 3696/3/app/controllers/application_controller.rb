# frozen_string_literal: true

require 'sinatra/flash'
require 'sinatra/namespace'
require 'truemail'
require_relative '../helpers/auth_helper'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SECRET')
  end

  Truemail.configure do |config|
    config.verifier_email = 'ojiknpe@net8mail.com'
  end

  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  helpers AuthHelper

  get '/' do
    @places = Place.all
    erb :home
  end

  use SessionsController
  use PlacesController
  use ReviewsController
end
