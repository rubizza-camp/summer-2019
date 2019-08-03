require_relative 'application_controller'

class SessionsController < ApplicationController
  get '/sign_in' do
    erb :sign_in
  end

  post '/sessions' do
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:notice] = 'Invalid email/password combo!'
      redirect '/sign_in'
    end
  end

  get '/logout' do
    session.delete(:user_id)
    redirect back
  end
end
