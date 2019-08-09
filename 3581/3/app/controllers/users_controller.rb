class UserController < ApplicationController
  before '/sign_*' do
    redirect '/' if session?
  end

  get '/sign_in' do
    erb :sign_in
  end

  get '/sign_up' do
    erb :sign_up
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/sign_in' do
    @user = User.find_by(email: params['email'])
    if @user && (@user.password == params[:password])
      session_start!
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = I18n.t(:invalid_credentials)
      erb :sign_in
    end
  end

  post '/sign_up' do
    @user = User.new(name: params['name'], email: params['email'])
    @user.password = params[:password]
    if @user.save
      session_start!
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = @user.errors.messages.values.join(' ')
      erb :sign_up
    end
  end
end
