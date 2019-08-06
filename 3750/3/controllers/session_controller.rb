# frozen_string_literal: true

require_relative 'base_controller'

class SessionController < BaseController
  def user
    @user ||= User.new(login: params['name'], email: params['email'],
                       password_hash: params['password'])
  end

  post '/sessions/signup' do
    user.email_valid? ? successful_registration : registration_fail
  end

  post '/sessions/login' do
    @user = User.find_by(email: params[:email])
    login_fail unless @user

    @user.validate_login(params[:password]) ? session[:user_id] = @user.id : login_fail
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/sessions/signup' do
    erb :'/sessions/signup'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  private

  def successful_registration
    user.save
    session[:user_id] = user.id
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
end
