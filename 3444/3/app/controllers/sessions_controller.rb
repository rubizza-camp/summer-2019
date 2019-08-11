class SessionsController < ApplicationController
  get '/login' do
    erb :'auth/login'
  end

  post '/login' do
    env['warden'].authenticate!

    flash[:success] = 'Successfully logged in'

    redirect session.fetch(:return_to, '/')
  end

  post '/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end
end
