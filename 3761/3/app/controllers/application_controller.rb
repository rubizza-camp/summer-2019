require 'rack-flash'
require 'dotenv'
require_relative '../helpers/user_helper'
require_relative '../helpers/session_helper'

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  register Sinatra::ActiveRecordExtension
  helpers UserHelper
  helpers SessionHelper

  Dotenv.load

  use Rack::Flash
  configure do
    set :session_fail, '/sign_up'
    set :session_secret, ENV['SESSION_SECRET']
    set views: proc { File.join(root, '../views/') }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
end
