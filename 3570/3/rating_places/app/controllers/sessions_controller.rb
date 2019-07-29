require_relative 'base_controller'

class SessionsController < BaseController
  get '/sessions/login' do
    erb :'/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      redirect '/sessions/login'
    end
  end
end
