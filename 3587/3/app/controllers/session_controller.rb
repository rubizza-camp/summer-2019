class SessionController < ApplicationController
  get '/register' do
    return redirect '/' if session?
    erb :register
  end

  post '/register' do
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    if @user.valid?
      @user.save!
      redirect '/login'
    end
    erb :register
  end

  get '/login' do
    return redirect '/' if session?
    erb :login
  end

  post '/login' do
    start_session if account_exist?
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
