class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
end