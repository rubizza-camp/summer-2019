# frozen_string_literal: true

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
    add_user if valid_user_registration?
  end

  post '/sign_in' do
    valid_log_state
    @user = User.find_by(email: params[:email])
    sign_in_user if valid_user_login?
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/'
  end
end
