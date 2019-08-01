require 'dotenv'
require 'rack-flash'
require_relative '../helper/user_helper'
require_relative '../helper/session_helper'

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers UserHelper
  helpers SessionHelper

  MAX_RATING = 5
  use Rack::Flash
  Dotenv.load

  configure do
    set :session_fail, '/register'
    set :session_secret, ENV['SESSION_SECRET']
    set public_folder: proc { File.join(root, '../../public/') }
    set views: proc { File.join(root, '../views/') }
    enable :sessions
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  I18n.load_path << Dir[File.expand_path('config') + '/*.yml']
end
