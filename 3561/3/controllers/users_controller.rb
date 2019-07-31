require_relative '../controllers/application_controller'

class UsersController < ApplicationController
  post '/users' do
    new_user = User.new(name: params[:usrname], email: params[:email], password: params[:password])
    if new_user.save
      session[:user_id] = user[:id].to_s
    else
      session[:message] = 'Invalid credentials'
    end
    redirect_back
  end

  post '/login' do
    if user && user.password == params[:password]
      session[:user_id] = user[:id].to_s
    else
      session[:message] = 'Password or email is incorrect'
    end
    redirect_back
  end

  get '/delete_user_from_session' do
    delete_from_session :user_id
  end

  get '/delete_message_from_session' do
    delete_from_session :message
  end

  private

  def delete_from_session(symbol)
    session.delete symbol
    redirect_back
  end

  def user
    @user ||= User.find_by(email: params['email'])
  end
end
