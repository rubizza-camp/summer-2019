require_relative 'base_controller'

class SessionController < BaseController
  post '/sessions/signup' do
    @user = User.new(login: params['name'], email: params['email'],
                     password: params['password'])
    # binding.pry
    if email_exists?
      @user.save
      login
      info_message 'Registration done'
      redirect '/'
    else
      error_message 'Something went wrong(email)'
      redirect '/sessions/signup'
    end
  end

  post '/sessions/login' do
    @user = User.find_by(email: params[:email])
    if user_exists?
      login
      info_message 'Success!'
      redirect '/'
    else
      error_message 'wrong login or password'
      redirect '/'
    end
  end

  def login
    session[:user_id] = @user.id
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  def user_exists?
    @user && (@user.password == params[:password])
  end

  def email_exists?
    Truemail.valid?(params['email'])
  end

  get '/index' do
    @users = User.all
    erb :index
  end

  get '/sessions/signup' do
    erb :'/sessions/signup'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end
end
