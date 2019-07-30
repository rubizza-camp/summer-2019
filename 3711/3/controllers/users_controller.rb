require_relative '../helpers/auth'
require_relative '../helpers/crypt'
require_relative '../helpers/flash'

class UsersController < Sinatra::Base
  include AuthHelper
  include CryptHelper
  include FlashHelper

  register Sinatra::Flash

  configure do
    set :views, (proc { File.join(root, '../views/users') })
  end

  get '/login' do
    session[:back] = back
    erb :login
  end

  post '/login' do
    @user = User.find_by(mail: params[:mail])
    if correct_login?
      flash_info('Successful loged in!')
      authorization
    else
      retry_login
    end
  end

  get '/signup' do
    session[:back] = back
    erb :signup
  end

  post '/signup' do
    return if signup_mail_check(params['mail'])

    @user = User.create(mail: params['mail'], username: params['u_name'],
                        pass_hash: md5_encrypt(params['password']),
                        first_name: params['f_name'], last_name: params['l_name'])
    authorization
  end

  get '/logoff' do
    logoff
  end
end
