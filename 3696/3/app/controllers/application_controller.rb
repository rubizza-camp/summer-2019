# frozen_string_literal: true

require 'sinatra/flash'
require 'sinatra/namespace'
require 'truemail'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SECRET')
  end

  register Sinatra::Namespace

  Truemail.configure do |config|
    config.verifier_email = 'ojiknpe@net8mail.com'
  end

  use SessionsController
  use PlacesController
  namespace('/review') { use ReviewsController }
end
