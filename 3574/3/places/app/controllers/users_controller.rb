class UsersController < ApplicationController
  get '/registration' do
    erb :registration
  end

  get '/login' do
    erb :login
  end

  post '/registration' do
    @user = User.create(user_params)
    if @user.valid?
      flash[:success] = 'Registration complete!'
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:danger] = 'Your email is invalid!'
      redirect('/registration')
    end
  end

  post '/login' do
    if user?
      flash[:success] = 'Login complete!'
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:danger] = 'Wrong password!'
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  private

  def user_params
    params.slice('username', 'email', 'password')
  end

  def user?
    @user = User.find_by(email: params[:email], password: params[:password])
  end
end
