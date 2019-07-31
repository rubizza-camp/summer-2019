require './config/environment'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'best_restaraunts'
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  def logged_in?
    session[:user_id]
  end

  def current_user
    @user = User.find(session[:user_id])
  end

  not_found do
    erb :not_found, layout: false
  end
end
