require_relative 'application_controller'

# :reek:RepeatedConditional
class UsersController < ApplicationController
  get '/login/sign_up' do
    erb :login_sign_up
  end

  post '/login/new' do
    new_user = User.new(
      name: params[:user_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:confirm_password]
    )
    result = new_user.save
    if result
      session[:identity] = new_user.id
      redirect '/'
    else
      @error = new_user.errors.full_messages.first
      erb :login_sign_up
    end
  end

  get '/login/sign_in' do
    erb :login_sign_in
  end

  post '/login/auth' do
    @error = 'Enter e-mail' if params[:email] == ''
    @error = 'Enter password' if params[:password] == ''
    return erb :login_sign_in if @error

    user = User.find_by(email: params[:email])
    @error = 'E-mail not found' unless user
    return erb :login_sign_in if @error

    @error = 'Password wrong' if user.try(:authenticate, params[:password]) == false
    return erb :login_sign_in if @error

    session[:identity] = user.id
    redirect '/'
  end

  get '/logout' do
    session.delete(:identity)
    erb "<div class='alert alert-message'>Logged out</div>"
  end
end
