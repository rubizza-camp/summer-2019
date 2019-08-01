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
    # rubocop:disable Style/DoubleNegation
    def logged_in?
      !!session[:user_id]
    end
    # rubocop:enable Style/DoubleNegation
  end
end
