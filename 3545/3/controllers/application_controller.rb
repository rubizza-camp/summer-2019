require 'dotenv'
Dotenv.load

class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['SECRET_KEY']
  set :views, './views'
  configure do
    register Sinatra::Flash
  end

  get '/' do
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      @locations = Location.all
      @users = User.all
      erb :index
    else
      redirect '/login'
    end
  end
end
