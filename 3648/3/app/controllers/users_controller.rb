#:reek:RepeatedConditional
class UserController < ApplicationController
  get '/singup' do
    if logged?
      flash[:message] = 'You already logged'
      redirect to '/'
    else
      erb :singup
    end
  end

  post '/singup' do
    if logged?
      flash[:message] = 'You already logged'
      redirect to '/'
    elsif params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = 'You must fill all'
      redirect to '/singup'
    else
      @user = User.create(
        username: params[:username],
        email: params[:email],
        password: params[:password]
      )
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  get '/login' do
    if logged?
      flash[:message] = 'You already logged'
      redirect to '/'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
    else
      flash[:message] = 'Wrong password'
    end
    redirect to '/login'
  end

  get '/logout' do
    if logged?
      session.clear
      flash[:message] = 'You have been logged out'
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
