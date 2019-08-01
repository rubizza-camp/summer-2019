class SessionsController < ApplicationController
  get '/register' do
    return redirect '/' if session?
    erb :register
  end

  post '/register' do
    if password? && @user.valid? && @user.save
      redirect '/login'
    else
      flash[:error] = I18n.t(:incorrect_password_or_email)
    end
    erb :register
  end

  get '/login' do
    return redirect '/' if session?
    erb :login
  end

  post '/login' do
    start_session if account_exists?
    redirect '/login'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end
end
