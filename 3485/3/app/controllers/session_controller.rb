class SessionController < ApplicationController
  get '/login' do
    erb :login
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
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect back
  end
end
