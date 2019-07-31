require 'bcrypt'
require_relative 'application_controller'

class SessionsController < ApplicationController
  set :views, File.realpath('./views/sessions')

  bcrypt = BCrypt::Password

  get '/signup' do
    haml :signup, layout: false
  end

  post '/signup' do
    password = bcrypt.create(params[:password])
    User.create email: params[:email], password: password
    redirect '/'
  end

  get '/login' do
    haml :login, layout: false
  end

  post '/login' do
    user = User.find_by(email: params[:email])

    if user && (bcrypt.new(user.password) == params[:password])
      session[:email] = params[:email]
    else
      flash[:message] = 'Wrong credentials.'
    end

    redirect '/'
  end

  get '/logout' do
    session[:email] = nil
    redirect '/'
  end
end
