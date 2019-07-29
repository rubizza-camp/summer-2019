class UserController < ApplicationController

  get '/signup' do
    if is_logged_in?
      flash[:message] = "Already logged in"
      redirect to '/'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if is_logged_in?
      flash[:message] = "Already logged in"
      redirect to '/'
    elsif params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:message] = "You must fill all forms"
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  get '/login' do
    if is_logged_in?
      flash[:mesage] = "Already logged in"
      redirect to '/'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/'
    else
      flash[:message] = "Incorrect password"
      redirect to '/'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      flash[:message] = "You have been logged out"
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
