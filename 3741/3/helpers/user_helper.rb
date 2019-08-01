# frozen_string_literal: true

require 'sinatra/base'

module UserHelper
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

  def sign_in_redirect
    if user_data_valid?
      session[:user_id] = @user.id
      redirect '/'
    else
      show_message 'wrong email'
      redirect '/session/login'
    end
  end

  def register_data_valid?
    @user = User.new(params.slice('username', 'email', 'password'))
    @user.valid? && Truemail.valid?(params['email'])
  end

  def user_data_valid?
    @user = User.find_by(email: params[:email])
    @user && @user.password == params[:password]
  end
end
