require_relative '../controllers/application_controller'

class UsersController < ApplicationController
  post '/users' do
    if params[:password] == params[:password_again]
      new_user = User.new(name: params[:usrname],
                          email: params[:email],
                          password: params[:password])
      save_user_in_session new_user
    else
      'Password not equals'
    end
  end

  post '/login' do
    if user && user.password == params[:password]
      session[:user_id] = user[:id].to_s
      'Done'
    else
      'Password or email is incorrect'
    end
  end

  get '/delete_user_from_session' do
    delete_from_session :user_id
  end

  private

  def delete_from_session(symbol)
    session.delete symbol
    redirect_back
  end

  def save_user_in_session(new_user)
    if new_user.save
      session[:user_id] = user[:id].to_s
      'Done'
    else
      'Invalid credentials'
    end
  end

  def user
    @user ||= User.find_by(email: params['email'])
  end
end
