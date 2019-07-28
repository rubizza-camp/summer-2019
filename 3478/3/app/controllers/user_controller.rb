require_relative '../../helpers/user_helper'
require 'digest'

class UserController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  include UserHelper

  get '/sign_up' do
    erb :sign_up
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/sign_up' do
    @user = User.new(name: params['username'], email: params['email'], password: params['password'])
    if valid_user_registration?
      add_user
    end
  end

  post '/sign_in' do
    valid_log_state
    @user = User.find_by(email: params[:email])
    if valid_user_login?
      sign_in_user
    end
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/'
    end
end
