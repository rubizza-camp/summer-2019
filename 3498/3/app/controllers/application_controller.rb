require 'sinatra'
require 'bcrypt'

class ApplicationController < Sinatra::Base
  set :database, ENV['DB_PATH']
  set :views, 'app/views'

  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
  end
end
