# require_relative 'base_controller'
class UsersController < BaseController
  get '/users' do
    @users = User.all
    erb :'users/index', layout: :layout
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(login: params[:login], email: params[:email], password: params[:password])
    flash[:error] = @user.errors.full_messages unless @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect '/users'
    else
      flash[:error] = 'alarm'
      redirect '/'
    end
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/users'
    else
      flash[:error] = 'alarm'
      redirect '/'
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
end
