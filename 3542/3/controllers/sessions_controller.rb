require 'bcrypt'
require_relative 'application_controller'

class SessionsController < ApplicationController
  set :views, File.realpath('./views/sessions')

  get '/signup' do
    haml :signup, layout: false
  end

  post '/signup' do
    User.create email: params[:email], password: params[:password]
    redirect '/'
  end

  get '/login' do
    haml :login, layout: false
  end

  post '/login' do
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
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
