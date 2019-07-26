require 'sinatra/base'

class AuthHelper < Sinatra::Base
  module Helpers
    def user_exists?
      @user && (@user.password == params[:password])
    end

    def user_logged?
      session[:user_id]
    end

    def can_register?
      @user.valid? && Truemail.valid?(params['email'])
    end

    def log_in
      session[:user_id] = @user.id
    end

    def avoid_repeated_login
      return unless user_logged?

      warning_message 'You are logged already'
      redirect '/'
    end

    def avoid_repeated_logout
      return if user_logged?

      warning_message 'You are logged out already'
      redirect '/'
    end
  end

  helpers Helpers
end
