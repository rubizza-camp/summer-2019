class UsersController < ApplicationController
  attr_reader :user

  get '/login' do
    erb :'users/log_in.html'
  end

  post '/login' do
    @user = User.find_by(params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/posts/all'
    else
      session[:error] = 'Log in failed!'
      redirect '/users/login'
    end
  end

  get '/signin' do
    erb :'users/sign_in.html'
  end

  post '/signin' do
    @user = User.new(params[:user])
    if @user.save!
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
