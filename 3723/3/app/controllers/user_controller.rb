#:reek:RepeatedConditional
class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      flash[:notice] = 'Already logged in'
      redirect to '/'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(
      username: params[:username],
      password: params[:password],
      email: params[:email]
    )
    @user.save
    session[:user_id] = @user.id
    redirect to '/'
  end

  get '/login' do
    if logged_in?
      flash[:notice] = 'Already logged in'
      redirect to '/'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
    else
      flash[:notice] = 'Incorrect password'
    end
    redirect to '/'
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:notice] = 'You have been logged out'
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
