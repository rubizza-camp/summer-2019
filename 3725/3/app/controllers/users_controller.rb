require_relative '../helpers/auth'

class UsersController < ApplicationController

  attr_reader :user

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      
    else
      redirect_to home_url
    end
  end

  get '/auth/sign_in' do
    haml :sign_in
  end

  post '/auth/sign_in' do
    user_params = params[:user]
    user = User.find_by email: user_params[:email]
    if user.password == user_params[:password]
      generate_token
      write_token_to_session

      redirect to('/')
    else
      haml :sign_in
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params[:user])
    @user.password = params[:password]
    @user.save!
    authorization
  end


end
