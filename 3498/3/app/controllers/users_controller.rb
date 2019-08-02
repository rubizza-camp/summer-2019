class UsersController < Sinatra::Base
  include BCrypt
  include UsersHelper

  get '/signup' do
    erb :signup
  end

  post '/registrations' do
    @user = User.new(name: params[:username], email: params[:email], password: params[:password])
    params[:password] ? @user.save : session[:error] = 'Enter password'
    session[:user_id] = @user.id.to_s
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    session.clear if login?
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id.to_s
    else
      session[:error] = 'Wrong password'
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  def login?
    session[:user_id]
  end
end
