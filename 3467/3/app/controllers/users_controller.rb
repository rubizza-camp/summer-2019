class UsersController < ApplicationController
  get '/register' do
    @user = User.new
    erb :register
  end

  post '/register' do
    @user = User.new(params[:user])
    if params[:password].empty?
      @error = 'Введите пароль'
    elsif params[:password] != params[:password_confirmation]
      @error = 'Подтверждение пароля не совпадает с паролем'
    else
      @user.password = params[:password]
      if @user.save
        redirect '/login'
      else
        @error = @user.errors.full_messages.first
      end
    end
    erb :register
  end

  get '/login' do
    @anonymous = User.new
    erb :login
  end

  post '/login' do
    @user = User.find_by_email(params[:user][:email].downcase)
    if @user
      if @user.password == params[:password]
        session[:user_id] = @user.id
        redirect '/'
      else
        @error = 'Неправильный пароль'
      end
    else
      @error = 'Нет пользователя с таким E-mail'
    end
    @anonymous = User.new(params[:user])
    erb :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
