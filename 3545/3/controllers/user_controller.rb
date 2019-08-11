require_relative 'application_controller'

class UsersController < ApplicationController
  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/failure'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/wrong'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/failure' do
    erb :failure, layout: false
  end

  get '/wrong' do
    erb :wrong, layout: false
  end
end
