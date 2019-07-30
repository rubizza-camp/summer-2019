require 'dotenv'
require 'rack-flash'
require_relative '../helper/session_helper'

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers SessionHelper

  use Rack::Flash
  Dotenv.load
  SESSION_SECRET = ENV['SESSION_SECRET']

  configure do
    set :session_fail, '/register'
    set :session_secret, SESSION_SECRET
    set views: proc { File.join(root, '../views/') }
    enable :sessions
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end
end
