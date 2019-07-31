class ApplicationController < Sinatra::Base
  Tilt.register Tilt::ERBTemplate, 'html.erb'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_KEY']
    register Sinatra::Flash
  end

  def logged_in?
    session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end
