require 'pry'

class UsersController < ApplicationController

  attr_reader :user

  get '/login' do
    erb :'users/log_in.html'
  end

  post '/login' do
    binding.pry
    @user = User.find_by(params[:email])
    if @user.password == params[:password]
      session[:user_id] = user.id
      redirect '/posts/all'
    else
      redirect '/users/login'
    end
  end

  get '/signin' do
    erb :'users/sign_in.html'
  end

  post '/signin' do
    binding.pry
    @user = User.new(params[:user])
    @user.save!
    session[:user_id] = user.id
    redirect '/posts/all'
  end

  post '/logout' do
    session.clear
    redirect '/posts/all'
  end


end
