class SessionController < ApplicationController
  get '/register' do
    return redirect '/' if session?
    erb :register
  end

  post '/register' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if valid_email? && valid_password?
      @user.save!
      redirect '/login'
    end
  end

  get '/login' do
    return redirect '/' if session?
    erb :login
  end

  post '/login' do
    if account_exist?
      session_start!
      session['user_id'] = @user.id
      redirect '/'
    end
    erb :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
