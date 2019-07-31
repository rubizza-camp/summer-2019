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

  post('/signin', needs: %i[email password]) do
    session[:current_user] = User.where(email: params[:email], password: params[:password]).first
    redirect('/')
  end

  get('/signup') do
    erb(:signup)
  end

  post('/signup', needs: %i[first_name last_name email password password_confirmation]) do
    session[:current_user] = User.create(params)
    redirect('/')
  end

  get('/signout') do
    session.delete(:current_user)
    redirect('/')
  end
end
