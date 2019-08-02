# frozen_string_literal: true

require_relative 'main_controller'

class SessionsController < MainController
  helpers do
    def redirect_if_logged_in
      return unless user_logged?

      show_message 'login in already'
      redirect '/'
    end

    def redirect_if_logged_out
      return if user_logged?

      show_message 'Logout already'
      redirect '/'
    end
  end

  namespace '/session' do
    before do
      redirect_if_logged_in if request.path_info == '/session/login' ||
                               request.path_info == '/session/signup'
    end

    get '/logout' do
      redirect_if_logged_out
      session.clear
      redirect '/'
    end

    get '/signup' do
      erb :signup
    end

    get '/login' do
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
