require 'rack-flash'
require 'sinatra'
require 'sinatra/json'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
