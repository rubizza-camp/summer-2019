require 'sinatra/base'
require 'sinatra/session'
require 'truemail'


class SessionController < ApplicationController
  register Sinatra::Session
  get '/register' do
    if session?
      redirect '/'
    else
      erb :register
    end
  end

  post '/register' do
    if params[:password].empty?
      @error = 'Введите пароль'
    else
      @user = User.new(name: params[:name], email: params[:email], password: params[:password])
      unless Truemail.valid?(params[:email])
        @error = 'Неправильная почта'
        redirect '/register'
      end
      if @user.save!
        redirect '/login'
      else
        @error = @user.errors.full_messages.first
      end
    end
    erb :register
  end

  get '/login' do
    if session?
      redirect '/'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by_email(params[:email])
    if @user
      if @user.password == params[:password]
        session_start!
        session['user_id'] = @user.id
        redirect '/'
      else
        @error = 'Неверный пароль'
      end
    else
      @error = 'Нет пользователя с таким E-mail'
    end
    erb :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end