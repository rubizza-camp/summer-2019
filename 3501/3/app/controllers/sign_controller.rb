# frozen_string_literal: true

require 'sinatra/flash'
require 'sinatra/base'
require 'sinatra/cookies'
require 'sinatra/strong-params'
require './app/lib/helper/user_default_error'
require './app/lib/user'

class SignController < Sinatra::Base
  register Sinatra::Flash
  register Sinatra::StrongParams
  helpers Sinatra::Cookies
  get('/signin') do
    erb(:signin)
  end

  post('/signin', allows: %i[email password], needs: %i[email password]) do
    session[:user_id] = User.sign_in_user(self).id
    redirect('/')
  rescue UserDefaultError => error
    flash.now[:error] = error.message
    erb(:signin)
  end

  get('/signup') do
    erb(:signup)
  end

  post('/signup', allows: %i[first_name last_name email password password_confirmation],
                  needs: %i[first_name last_name email password password_confirmation]) do
    User.sign_up_user(self)
    redirect('/')
  rescue UserDefaultError => error
    flash.now[:error] = error.message
    erb(:signup)
  end

  get('/signout') do
    session.delete(:user_id)
    redirect('/')
  end
end
