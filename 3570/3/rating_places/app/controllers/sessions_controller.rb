require_relative 'application_controller'

class SessionsController < ApplicationController
  get '/sessions/login' do
    erb :'/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  post '/sessions/login' do
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      redirect '/sessions/login'
    end
  end
end
