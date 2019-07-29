# frozen_string_literal: true

require 'sinatra/cookies'
require 'sinatra/base'
require './app/lib/user'

class ApplicationController < Sinatra::Base
  helpers Sinatra::Cookies
  get('/') do
    session[:current_user] = User.find_user_by_token(cookies[:user_token_id])
    erb(:main)
  end

  post('/') do
    erb(:main)
  end
end
