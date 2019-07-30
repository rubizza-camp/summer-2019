require 'sinatra/flash'
require_relative 'crypt'

module AuthHelper
  def loged_in?
    session.key?(:user) && session[:user]
  end

  # def log_in_error
  #   return 'Incorrect mail' if 

  # end
  
  def currect_user
    session[:user]
  end

  def user_exists?
    @user && @user.pass_hash == md5_encrypt(params[:password])
  end

  def info_message(text)
    flash[:info] = text
  end

  def warning_message(text)
    flash[:danger] = text
  end

  def authorization
    session[:user] = @user
    redirect session[:back] || '/'
  end

  def logoff
    session.delete(:user)
    redirect back
  end
end
