class UsersController < ApplicationController
  attr_reader :user

  get '/login' do
    erb :'users/log_in'
  end

  post '/login' do
    @user = User.find_by(email: parsms[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/posts/all'
    else
      session[:error] = 'Log in failed!'
      redirect '/users/login'
    end
  end

  get '/signup' do
    erb :'users/sign_in'
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
      session[:user_id] = @user.id
      redirect '/posts/all'
    else
      session[:error] = 'Sign up failed!'
    end
  end

  get '/logout' do
    session.clear
    redirect '/posts/all'
  end

end
