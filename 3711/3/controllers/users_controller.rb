require_relative '../helpers/auth'
require_relative '../helpers/flash'

class UsersController < Sinatra::Base
  include AuthHelper
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

    @user = User.new(review_params)
    if @user.save
      authorization
    else
      retry_action('Error while user creating: validation error', '/signup')
    end
  end

  get '/logout' do
    logout
  end

  private

  def review_params
    param_arr = %i[mail username first_name last_name]
    param_hash = Hash[param_arr.collect { |name| [name, params[name.to_s]] }]
    param_hash[:pass_hash] = Digest::MD5.hexdigest(params['password'])
    param_hash
  end
end
