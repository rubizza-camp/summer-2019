# frozen_string_literal: true

require_relative 'base_controller'

class SessionsController < BaseController
  # rubocop:disable Metrics/BlockLength
  namespace '/session' do
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
      @user = User.new(username: params['username'], email: params['email'],
                       password: params['password'])
      if can_register?
        @user.save
        successful_login
      else
        warning_message 'Error. Someone has taken your e-mail or username:('
        redirect '/session/signup'
      end
    end

    post '/login' do
      avoid_repeated_login
      @user = User.find_by(email: params[:email])
      if user_exists?
        successful_login
      else
        warning_message 'No such user!'
        redirect '/session/login'
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
