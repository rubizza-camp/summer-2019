class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['KEY']
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  register Sinatra::StrongParams
end
