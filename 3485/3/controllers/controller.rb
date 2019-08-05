require_relative 'application_controller'
require 'bcrypt'

class Controller < ApplicationController
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = 'Неправильный email или пароль'
      redirect back
    end
  end

  post '/logout' do
    session[:user_id] = false
    redirect back
  end
end
