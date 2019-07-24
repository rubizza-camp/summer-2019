require 'sinatra'
require 'sinatra/reloader'

class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  run! if app_file == $0
end
