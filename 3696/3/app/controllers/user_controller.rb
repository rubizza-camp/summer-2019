# frozen_string_literal: true

require_relative '../helpers/auth_helper'
require_relative '../helpers/info_helper'

class UserController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  helpers Sinatra::AuthHelper
  helpers Sinatra::InfoHelper

  get '/signup' do
    avoid_repeated_login
    erb :signup
  end

  get '/login' do
    avoid_repeated_login
    erb :login
  end

  get '/logout' do
    avoid_repeated_logout
    session.clear
    redirect '/'
  end

  post '/signup' do
    avoid_repeated_login
    @user = User.new(name: params['name'], email: params['email'], password: params['password'])
    if can_register?
      @user.save
      log_in
      info_message 'Success!'
      redirect '/'
    else
      warning_message 'Error. Someone has taken your e-mail or username:('
      redirect '/signup'
    end
  end

  post '/login' do
    avoid_repeated_login
    @user = User.find_by(email: params[:email])
    if user_exists?
      log_in
      info_message 'Success!'
      redirect '/'
    else
      warning_message 'No such user!'
      redirect '/login'
    end
  end
end
