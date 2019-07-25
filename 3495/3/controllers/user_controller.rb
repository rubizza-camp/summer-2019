class UserController < ApplicationController
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    erb :main
  end

  post '/user_login' do
    user = User.where(['email = ? and password = ?', params['email'], params['pass']]).first
    if user
      session[:name] = user[:name].to_s
    else
      set :sessions, :message => 'Trouble with password or email'
    end
    redirect "#{@env["HTTP_REFERER"]}"
  end
  
  post '/user_logout' do
    session[:name] = nil
    redirect "#{@env["HTTP_REFERER"]}"
  end

  post '/user_registration' do
    User.create(name: params['name'], email: params['email'], password: params['pass'])
    redirect "#{@env["HTTP_REFERER"]}"
  end

  get '/restaurant_registration' do
    erb :restaurant_registration
  end

end