# frozen_string_literal: true

require_relative 'main_controller'

class SessionsController < MainController
  namespace '/session' do
    before do
      redirect_if_logged_in if request.path_info == '/session/login' ||
                               request.path_info == '/session/signup'
    end

    get '/logout' do
      redirect_if_logged_out
      session.clear
      redirect '/'
    end

    get '/signup' do
      erb :signup
    end

    get '/login' do
      erb :login
    end

    post '/signup' do
      sign_up_redirect
    end

    post '/login' do
      sign_in_redirect
    end
  end

  private

  def redirect_if_logged_in
    return unless user_logged?

    show_message 'login in already'
    redirect '/'
  end

  def redirect_if_logged_out
    return if user_logged?

    show_message 'Logout already'
    redirect '/'
  end

  def sign_up_redirect
    if register_data_valid?
      show_message 'user create, login in please'
      redirect '/'
    else
      show_message 'bad email or login already exist'
      redirect '/session/signup'
    end
  end

  def sign_in_redirect
    user = User.find_by(email: params[:email])
    if user_data_valid?(user)
      session[:user_id] = user.id
      redirect '/'
    else
      show_message 'wrong email'
      redirect '/session/login'
    end
  end

  def register_data_valid?
    new_user = create_user
    new_user.save if new_user.valid?
  end

  def user_data_valid?(user)
    user && user.password == params[:password]
  end

  def create_user
    User.new(params.slice('username', 'email', 'password'))
  end
end
