require_relative 'base_controller'
require_relative '../helpers/session_helper'

class SessionController < BaseController
  include SessionHelper

  post '/sessions/signup' do
    @user = User.new(login: params['name'], email: params['email'],
                     password_hash: encrypt_password(params['password']))
    if email_valid?
      @user.save
      login
      info_message 'Registration done'
      redirect '/'
    else
      error_message 'Something went wrong(email)'
      redirect '/sessions/signup'
    end
  end

  post '/sessions/login' do
    @user = User.find_by(email: params[:email])
    if user_exists?
      login
      redirect '/'
    else
      error_message 'Wrong login or password'
      redirect '/sessions/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/index' do
    @users = User.all
    erb :index
  end

  get '/sessions/signup' do
    erb :'/sessions/signup'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end
end
