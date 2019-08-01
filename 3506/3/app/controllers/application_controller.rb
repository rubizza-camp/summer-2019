class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'super secret'
  end

  register Sinatra::Flash

  not_found do
    status 404
    'Something wrong! Try to type URL correctly or call to UFO.'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
