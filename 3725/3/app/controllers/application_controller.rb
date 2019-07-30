require 'sinatra/base'

class ApplicationController < Sinatra::Base

  set :views, File.expand_path('../../views', __FILE__)

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    # set :session_secret, ENV['SESSION_KEY']
    register Sinatra::Flash
  end



  get '/' do
    @posts = Post.all
    erb :index
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

end
