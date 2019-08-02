class UsersController < Sinatra::Base
  include BCrypt
  include UsersHelper

  get '/signup' do
    erb :signup
  end

  post '/registrations' do
    register_user
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    session.clear if login?
    login_user
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
