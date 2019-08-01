class UsersController < ApplicationController
  configure do
    set :views, 'app/views'
  end

  get '/registration' do
    erb :registration
  end

  get '/login' do
    erb :login
  end

  post '/registration' do
    @user = User.create(user_params)
    if @user.invalid?
      flash[:danger] = 'Your email is invalid!'
      redirect('/registration')
    else
      flash[:success] = 'Registration complete!'
      session[:user_id] = @user.id
      redirect '/'
    end
  end

  post '/login' do
    if search_user
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

  def search_user
    @user = User.find_by(email: params[:email],
                         password_hash: BCrypt::Password.create(params[:password]))
  end
end
