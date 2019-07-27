require_relative 'base_controller'
class UsersController < BaseController
  get '/users' do
    @users = User.all
    erb :'users/index', layout: :layout
  end
end
