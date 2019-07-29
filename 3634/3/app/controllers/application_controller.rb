require 'rack-flash'
require 'sinatra'
require 'sinatra/json'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :views, 'app/views'
    set :public_folder, 'app/assets'
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

    # def redirect_if_not_logged_in
    #   if !logged_in?
    #     redirect "/login"
    #   end
    # end

    # def redirect_to_categories
    #   redirect to "/categories"
    # end
  end
end
