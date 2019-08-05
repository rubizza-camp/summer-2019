require 'sinatra/flash'
require 'dotenv'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  Dotenv.load
  SESSION_SECRET = ENV['SESSION_SECRET']

  configure do
    enable :sessions
    set :session_secret, SESSION_SECRET
    register Sinatra::Flash
  end
end
