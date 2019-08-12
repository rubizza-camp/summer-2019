require 'dotenv'
require 'rack-flash'
require_relative '../helper/user_helper'

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers UserHelper

  use Rack::Flash
  Dotenv.load

  configure do
    set :session_fail, '/register'
    set :session_secret, ENV['SESSION_SECRET']
    set public_folder: proc { File.join(root, '../../public/') }
    set views: proc { File.join(root, '../views/') }
    enable :sessions
  end

  I18n.load_path << Dir[File.expand_path('config') + '/*.yml']
end
