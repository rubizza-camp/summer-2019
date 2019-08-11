require 'dotenv'
require 'sinatra/base'
require 'pagy'
require 'pagy/extras/bootstrap'

Dotenv.load

class ApplicationController < Sinatra::Base
  include Pagy::Backend
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET']
  set :views, './views'
  set :public_folder, './public'
  configure do
    register Sinatra::Flash
  end

  helpers do
    include Pagy::Frontend
    Pagy::VARS[:items] = 4
  end

  get '/' do
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      @pagy, @locations = pagy(Location)
      erb :index
    else
      redirect '/login'
    end
  end
end

def pagy_get_vars(collection)
  {
    count: collection.count,
    page: params['page']
  }
end
