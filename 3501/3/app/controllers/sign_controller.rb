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
    return redirect('/') if User.sign_in_user(self)

    redirect('/signin')
  end

  get('/signup') do
    erb(:signup)
  end

  post('/signup') do
    return redirect('/signup') unless User.create_new_user(self)

    @current_user = User.find_user_by_token(cookies[:user_token_id])
    redirect('/')
  end

  get('/signout') do
    response.delete_cookie('user_token_id')
    redirect('/')
  end
end
