require_relative '../helpers/auth'
require_relative '../helpers/crypt'

class UsersController < Sinatra::Base
  include AuthHelper
  include CryptHelper

  configure do
    set :views, proc { File.join(root, '../views/users') }
  end

  get '/login' do
    session[:back] = back
    erb :login
  end

  post '/login' do
    @user = User.find_by(mail: params[:mail])
    return erb :login unless user_exists?

    session[:user] = @user
    redirect session[:back] || '/'
  end

  get '/signup' do
    session[:back] = back
    erb :signup
  end

  post '/signup' do
    @user = User.create(mail: params['mail'], username: params['username'],
                        pass_hash: md5_encrypt(params['password']),
                        first_name: params['f_name'], last_name: params['l_name'])
    session[:user] = @user
    redirect session[:back] || '/'
  end

  get '/logoff' do
    session[:user] = @user
    redirect back
  end
end
