class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, 'secret'
  set :views, "./views"

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
