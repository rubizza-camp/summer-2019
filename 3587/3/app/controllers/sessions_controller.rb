# :reek:InstanceVariableAssumption

class SessionsController < ApplicationController
  get '/register' do
    erb :register
  end

  post '/register' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      set_session_id
    else
      flash[:error] = I18n.t(:incorrect_password_or_email)
      erb :register
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      set_session_id
      redirect '/'
    else
      flash[:error] = I18n.t(:incorrect_password_or_email)
      erb :login
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  def set_session_id
    session['user_id'] = @user.id
  end
end
