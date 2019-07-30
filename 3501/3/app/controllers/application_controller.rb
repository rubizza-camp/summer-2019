# frozen_string_literal: true

require 'sinatra/cookies'
require 'sinatra/base'
require './app/lib/user'

class ApplicationController < Sinatra::Base
  helpers Sinatra::Cookies
  get('/') do
    erb(:main)
  end

  post('/') do
    erb(:main)
  end
end
