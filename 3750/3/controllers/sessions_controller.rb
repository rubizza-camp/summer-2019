require_relative 'base_controller'

class SessionsController < BaseController
  post '/registrations/signup' do
    @user = User.new(login: params['login'], email: params['email'],
                     password: params['password'])
    if email_exists?
      @user.save
      successful_login
      info_message 'Registration done'
      redirect '/'
    else
      error_message 'Something went wrong(email)'
      redirect '/registrations/signup'
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    successful_login if user_exists?
  end

  def user_exists?
    @user && (@user.password == params[:password])
  end

  def successful_login
    session[:user_id] = @user.id
    redirect '/'
  end

  def email_exists?
    Truemail.valid?(params['email'])
  end

  get '/index' do
    @users = User.all
    erb :index
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end
end
