require 'bcrypt'
require 'truemail'

#:reek:RepeatedConditional
class UsersController < ApplicationController
  get '/signup' do
    if current_user
      @user = current_user
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
      erb :registration
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect '/'
    else
      erb :login
    end
  end

  get '/login' do
    if current_user
      redirect '/'
    else
      erb :login
    end
  end

  get '/logout' do
    if current_user
      session.destroy
      redirect '/'
    end
  end
end
