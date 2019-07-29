class UserController < ApplicationController
  get '/sign_in' do
    if session?
      redirect '/'
    else
      erb :sign_in
    end
  end

  post '/sign_in' do
    @user = User.find_by(email: params['email'])
    if @user && @user.password == params[:password]
      session_start!
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = I18n.t(:incorrect_password)
      redirect '/sign_in'
    end
  end

  get '/sign_up' do
    if session?
      redirect '/'
    else
      erb :sign_up
    end
  end

  post '/sign_up' do
    @user = User.new(name: params['name'], email: params['email'])
    @user.password = params[:password]
    unless @user.valid?
      flash[:message] = I18n.t(:account_already_exist)
      redirect '/sign_up'
    end
    unless Truemail.valid?(params['email'])
      flash[:message] = I18n.t(:invalid_email)
      redirect '/sign_up'
    end
    @user.save
    session_start!
    session[:user_id] = @user.id
    redirect '/'
  end

  get '/logout' do
    session_end!
    redirect '/'
  end
end
