# frozen_string_literal: true

require 'sinatra/cookies'
require 'sinatra/base'
require './app/lib/user'

class SignController < Sinatra::Base
  helpers Sinatra::Cookies
  get('/signin') do
    erb(:signin)
  end

  post('/signin') do
    session[:current_user] = User.where(mail: params[:mail], password: params[:password]).first
    redirect('/')
  end

  get('/signup') do
    erb(:signup)
  end

  post('/signup') do
    session[:current_user] = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      mail: params[:mail],
      password: params[:password]
    )
    redirect('/')
  end

  get('/signout') do
    session.delete(:current_user)
    redirect('/')
  end
end
