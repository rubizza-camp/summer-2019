class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SINATRA_SECRET']
    register Sinatra::Flash
  end

  def logged?
    session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end
