class SessionsController < ApplicationController
  do_login = lambda do
    env['warden'].authenticate!

    flash[:success] = 'Successfully logged in'

    redirect session.fetch(:return_to, '/')
  end

  show_logout = lambda do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end

  show_login = lambda do
    erb :'auth/login'
  end

  get '/logout', &show_logout
  get '/login', &show_login
  post '/login', &do_login
end
