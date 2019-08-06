require_relative 'application_controller'
require_relative '../helpers/user_helper.rb'
require 'bcrypt'

class Controller < ApplicationController
  include UserHelper
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params['email'].downcase)
    login
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect back
  end
end
