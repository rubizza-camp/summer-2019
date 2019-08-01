# frozen_string_literal: true

require_relative 'main_controller'

class SessionsController < MainController
  helpers do
    def login_in?
      return unless user_logged?

      show_message 'login in already'
      redirect '/'
    end

    def login_out?
      return if user_logged?

      show_message 'Logout already'
      redirect '/'
    end
  end

  namespace '/session' do
    get '/logout' do
      login_out?
      session.clear
      redirect '/'
    end

    get '/signup' do
      login_in?
      erb :signup
    end

    get '/login' do
      login_in?
      erb :login
    end

    post '/signup' do
      sign_up_redirect
    end

    post '/login' do
      sign_in_redirect
    end
  end
end
