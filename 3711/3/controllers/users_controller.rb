require_relative '../helpers/auth'
require_relative '../helpers/crypt'

class UsersController < Sinatra::Base
  include AuthHelper
  include CryptHelper

  configure do
    set :views, Proc.new { File.join(root, '../views/users') }
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(mail: params[:mail])
    return redirect '/' if user_exists?

    session[:user_id] = @user.id
    puts @user
    puts session[:user_id]
    erb :login
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.create(mail: params['mail'], username: params['username'],
                        pass_hash: md5_encrypt(params['password']),
                        first_name: params['f_name'], last_name: params['l_name'])
    session[:user_id] = @user.id
    redirect '/'
  end

  # get '/users' do
  #   erb :index
  # end

  # get '/users/:user_id' do
  #   @user_id = params['name']
  #   erb :user
  # end
end
