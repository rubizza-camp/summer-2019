# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'
require 'sinatra/strong-params'
require './app/lib/user'

class SignController < Sinatra::Base
  register Sinatra::StrongParams
  helpers Sinatra::Cookies
  get('/signin') do
    erb(:signin)
  end

  post('/signin', allows: %i[email password], needs: %i[email password]) do
    session[:user_id] = User.sign_in_user(self).id
    redirect('/')
  end

  get('/signup') do
    erb(:signup)
  end

  post('/signup', allows: %i[first_name last_name email password password_confirmation],
                  needs: %i[first_name last_name email password password_confirmation]) do
    session[:user_id] = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: BCrypt::Password.create(params[:password]).to_s
    ).id
    redirect('/')
  end

  get('/signout') do
    session.delete(:user_id)
    redirect('/')
  end
end
