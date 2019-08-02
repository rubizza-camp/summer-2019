# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'
require './app/lib/user'
require './app/lib/snack_bar'

class ApplicationController < Sinatra::Base
  helpers Sinatra::Cookies
  get('/') do
    @snackbars = SnackBar.all
    @current_user = User.find_by_id(session[:user_id])
    erb(:main)
  end
end
