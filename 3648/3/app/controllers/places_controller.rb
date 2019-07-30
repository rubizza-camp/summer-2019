class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  get '/' do
    @place = Place.all
    erb :home
  end

  post '/register' do

  end

  post '/login' do 


  end

  get '/logout' do

  end

  get '/place/:name' do

  end
end
