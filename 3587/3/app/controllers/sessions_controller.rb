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
    if find_in_db && right_password?
      set_session_id
      redirect '/'
    else
      redirect '/login'
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  def find_in_db
    @user = User.find_by(email: params[:email])
  end

  def right_password?
    @user.password == params[:password]
  end

  def set_session_id
    session['user_id'] = @user.id
  end
end
