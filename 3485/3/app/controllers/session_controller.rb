class SessionController < ApplicationController
  before '/login' do
    redirect '/' if current_user
  end

  get '/login' do
    if current_user
      redirect '/'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = 'Invalid email or password.'
      redirect back
    end
  end

  post '/logout' do
    session.clear
    redirect back
  end
end
