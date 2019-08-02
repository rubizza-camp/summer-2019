require 'rack-flash'
require 'sinatra'
require 'sinatra/json'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :raise_errors, true
    set :show_exceptions, false
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  helpers do
    def current_user
      @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
    end
  end

  error ActiveRecord::RecordNotFound do
    slim :'restaurants/not_found.html', layout: :'layouts/application.html'
  end
end
