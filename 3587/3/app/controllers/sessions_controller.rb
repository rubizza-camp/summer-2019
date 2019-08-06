class SessionsController < ApplicationController
  get '/register' do
    return redirect '/' if session?

    erb :register
  end

  post '/register' do
    if params[:password] == params[:confirm_password] && @user.save
      @user = User.create(name: params[:name], email: params[:email], password: params[:password])
      login
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
    login
    redirect '/login'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end
end
