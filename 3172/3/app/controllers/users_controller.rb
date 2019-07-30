require_relative 'application_controller'

# :reek:RepeatedConditional
class UsersController < ApplicationController
  get '/login/sign_up' do
    erb :login_sign_up
  end

  post '/login/new' do
    hh = { user_name: 'Enter user name',
           email:     'Enter email',
           password:  'Enter password' }

    @error = hh.select { |key| params[key] == '' }.values.join(', ')
    return erb :login_sign_up if @error != ''

    user = User.find_by name: params[:user_name]
    @error = 'Username is busy' if user
    return erb :login_sign_up if @error != ''

    email = User.find_by email: params[:email]
    @error = 'E-mail is busy' if email
    return erb :login_sign_up if @error != ''

    new_user = User.new
    new_user.name = params[:user_name]
    new_user.email = params[:email]
    new_user.password = Digest::SHA1.hexdigest(params[:password])
    new_user.save

    session[:identity] = new_user.name
    redirect '/'
  end

  get '/login/sign_in' do
    erb :login_sign_in
  end

  post '/login/auth' do
    hh = { email: 'Enter e-mail',
           password:  'Enter password' }

    @error = hh.select { |key| params[key] == '' }.values.join(', ')
    return erb :login_sign_in if @error != ''

    user = User.find_by email: params[:email]
    @error = 'E-mail not found' unless user
    return erb :login_sign_in if @error != ''

    entered_password = Digest::SHA1.hexdigest(params[:password])
    @error = 'Password wrong' if user.password != entered_password
    return erb :login_sign_in if @error != ''

    session[:identity] = user.name
    redirect '/'
  end

  get '/logout' do
    session.delete(:identity)
    erb "<div class='alert alert-message'>Logged out</div>"
  end
end
