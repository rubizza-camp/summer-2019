require 'bcrypt'
require 'truemail'

class UsersController < ApplicationController
  get '/signup' do
    if current_user
      redirect '/'
    else
      erb :registration
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email],
                     password_hash: password(params[:password]))
    if @user.save && Truemail.valid?(params[:email])
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = 'Wrong input'
      redirect '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = 'Wrong input'
      redirect '/login'
    end
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    if current_user
      session.destroy
      redirect '/'
    end
  end
end
