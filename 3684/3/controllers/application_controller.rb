require 'sinatra/flash'
require 'sinatra/partial'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  configure do
    register Sinatra::Flash
    register Sinatra::Partial
    enable :sessions
    set :partial_template_engine, :erb
    set :session_secret, 'super_secret'
  end
end
