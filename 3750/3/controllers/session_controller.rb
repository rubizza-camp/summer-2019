# frozen_string_literal: true

require_relative 'base_controller'
require_relative '../services/session_service'

class SessionController < BaseController
  include SessionService

  post '/sessions/signup' do
    @user = User.new(login: params['name'], email: params['email'],
                     password_hash: params['password'])

    @user.email_valid? ? successful_registration : registration_fail
  end

  post '/sessions/login' do
    @user = User.find_by(email: params[:email])

    user_exists? ? login : login_fail
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
end
