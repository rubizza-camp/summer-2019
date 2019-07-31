# frozen_string_literal: true

require_relative 'base_controller'
# :reek:InstanceVariableAssumption
class SessionsController < BaseController
  helpers do
    def login_in?
      return unless user_logged?

      show_message 'login in already'
      redirect '/'
    end

    def login_out?
      return if user_logged?

      show_message 'Logout already'
      redirect '/'
    end

    def register_data_valid?
      @user.valid? && Truemail.valid?(params['email'])
    end
  end

  namespace '/session' do
    get '/signup' do
      login_in?
      erb :signup
    end

    get '/login' do
      login_in?
      erb :login
    end

    get '/logout' do
      login_out?
      session.clear
      redirect '/'
    end

    post '/signup' do
      login_in?
      @user = User.new(params.slice('username', 'email', 'password'))
      sign_up_redirect
    end

    post '/login' do
      login_in?
      @user = User.find_by(email: params[:email])
      login_redirect
    end
  end

  def sign_up_redirect
    if register_data_valid?
      @user.save
      show_message 'user create, login in please'
      redirect '/'
    else
      show_message 'email or login already exist'
      redirect '/session/signup'
    end
  end

  def login_redirect
    if @user && BCrypt::Password.new(@user.password_hash) == params[:password]
      session[:user_id] = @user.id
      redirect '/'
    else
      show_message 'wrong email'
      redirect '/session/login'
    end
  end
end
