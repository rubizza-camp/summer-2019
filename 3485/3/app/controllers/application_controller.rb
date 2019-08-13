class ApplicationController < Sinatra::Base
  Dotenv.load
  SESSION_SECRET = ENV['SESSION_SECRET']

  configure do
    enable :sessions
    set :show_exceptions, :after_handler
    set :session_secret, SESSION_SECRET
    set :views, 'app/views'
    set :public_dir, 'public'
    register Sinatra::Flash
  end

  error ActiveRecord::RecordNotFound do
    erb :not_found
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
