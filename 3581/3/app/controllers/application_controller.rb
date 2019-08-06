require 'rack-flash'
require 'dotenv'

class ApplicationController < Sinatra::Base
  Dotenv.load
  SESSION_SECRET = ENV['SESSION_SECRET']
  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  use Rack::Flash
  configure do
    set :session_fail, '/sign_up'
    set :session_secret, SESSION_SECRET
    set views: proc { File.join(root, '../views/') }
    set assets: proc { File.join(root, '../app/assets/') }
  end

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']

  def current_user?
    User.exists?(id: session[:user_id])
  end
end
