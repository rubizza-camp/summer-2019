# frozen_string_literal: true

require 'sinatra/flash'
require 'truemail'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SECRET')
  end

  Truemail.configure do |config|
    config.verifier_email = 'ojiknpe@net8mail.com'
  end

  helpers Sinatra::AuthHelper

  use UserController
  use PlaceController
  use ReviewController
end
