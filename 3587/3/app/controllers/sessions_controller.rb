class SessionsController < ApplicationController
  get '/register' do
    erb :register
  end

  post '/register' do
    @user = User.create(name: params[:name], email: params[:email], password: params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.save
      login
    else
      flash[:error] = I18n.t(:incorrect_password_or_email)
      erb :register
    end
  end

  get '/login' do
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
