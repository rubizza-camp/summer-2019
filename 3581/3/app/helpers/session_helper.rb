require 'sinatra/base'

module SessionHelper
  def session_start
    session_start!
    session[:user_id] = @user.id
    redirect '/'
  end
end
