# frozen_string_literal: true

require './config/environment'
class AppController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  configure do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
    enable :sessions
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :session_secret, ENV['key']
  end

  get '/' do
    erb :index, layout: :layout
  end
end
