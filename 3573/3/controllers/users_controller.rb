class UsersController < ApplicationController
  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    if params[:password] == params[:password_confirm]
      new_user = User.new(name: params[:username],
                          email: params[:email],
                          password: params[:password])
      save_user(new_user)
    else
      session[:message] = 'Password not equals'
    end
  end

  post '/login' do
    if user && user.password == params[:password]
      session[:user_id] = user[:id].to_s
    else
      session[:message] = 'Password or email is incorrect'
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/delete_session_message' do
    delete_session_message :message
  end

  private

  def delete_session_message(symbol)
    session.delete symbol
    redirect '/'
  end

  def save_user(new_user)
    if new_user.save
      session[:user_id] = user[:id].to_s
      redirect '/'
    else
      session[:message] = 'Invalid credentials'
    end
  end

  def user
    @user ||= User.find_by(email: params['email'])
  end
end
