require_relative 'base_controller'

class UsersController < BaseController
  get '/users/new' do
    erb :'/users/new'
  end

  post '/users/new' do
    @user = User.new(name: params['name'], email: params['email'],
                     password: params['password'])
    @user.save
    session[:user_id] = @user.id
    redirect '/'
  end
end
