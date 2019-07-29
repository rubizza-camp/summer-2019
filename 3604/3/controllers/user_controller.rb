require 'sinatra/session'
require 'sinatra'
require './models/user.rb'
require 'rack-flash'
require 'dotenv'

class UserController < Sinatra::Base
  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  use Rack::Flash

  set views: proc { File.join(root, '../views/') }
  set models: proc { File.join(root, '../models/') }
  set :session_fail, '/sign_in'
  Dotenv.load
  set :session_secret, ENV['SESSION_SECRET']

  get '/sign_in' do
    if session?
      redirect '/main'
    else
      erb :sign_in
    end
  end

  post '/sign_in' do
    @user = User.find_by(email: params['email'])
    if @user && @user.password == params[:password]
      session_start!
      session[:user_id] = @user.id
      redirect '/main'
    else
      flash[:message] = 'Incorrect password or you do not sign up'
      redirect '/sign_in'
    end
  end

  get '/sign_out' do
    session_end!
    redirect '/main'
  end

  get '/sign_up' do
    if session?
      redirect '/main'
    else
      erb :sign_up
    end
  end

  post '/sign_up' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.valid?
      @user.save
      session_start!
      session[:user_id] = @user.id
      redirect '/main'
    else
      flash[:message] = 'Invalid email'
      redirect '/sign_up'
    end
  end
end
