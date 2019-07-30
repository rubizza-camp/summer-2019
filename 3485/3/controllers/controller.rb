require_relative 'application_controller'
require_relative 'placename'
require 'bcrypt'

class Controller < ApplicationController
  # include PlaceName

  post '/registration' do
    password = BCrypt::Password.create(params['password'])
    hash = { name: params['name'], email: params['email'], password: password }
    Users.create(hash)
    session[:users_id] = Users.last.id
    redirect '/home'
  end

  post '/login' do
    @users = Users.find_by(email: params['email'])
    if @users
      if BCrypt::Password.new(@users[:password]) == params['password']
        session[:users_id] = @users.id
        redirect '/home'
      else
        session[:users_id] = true
      end
      redirect '/home'
    else
      session[:users_id] = true
    end
    redirect '/home'
  end

  get '/logout' do
    session[:users_id] = false
    redirect '/home'
  end

  get '/home' do
    erb :home
  end

  get '/registration' do
    erb :registration
  end
end
