# frozen_string_literal: true

require 'sinatra/base'

module SessionService
  def user_exists?
    @user && (@user.password_hash == params[:password])
  end

  def successful_registration
    @user.save
    login
    info_message 'Registration done'
    redirect '/'
  end

  def registration_fail
    error_message 'Invalid email or password'
    redirect '/sessions/signup'
  end

  def login_fail
    error_message 'Wrong login or password'
    redirect '/sessions/login'
  end

  def login
    session[:user_id] = @user.id
  end
end
