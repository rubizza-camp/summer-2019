require_relative 'application_controller'

class UsersController < ApplicationController
  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    @user = User.new(name: params['name'], email: params['email'],
                     password: params['password'])
    @user.save
    session[:user_id] = @user.id
    redirect '/'
  end
end
