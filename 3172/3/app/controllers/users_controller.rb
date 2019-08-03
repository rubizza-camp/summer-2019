require_relative 'application_controller'

class UsersController < ApplicationController
  post '/users' do
    new_user = User.new(
      name: params[:user_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:confirm_password]
    )
    result = new_user.save
    if result
      session[:user_id] = new_user.id
      redirect '/'
    else
      flash[:notice] = new_user.errors.full_messages.join('; ')
      redirect '/sign_up'
    end
  end
end
