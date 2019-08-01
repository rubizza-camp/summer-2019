# frozen_string_literal: true

require 'helpers/view_helper'
require 'helpers/user_helper'

# main class
class MainController < Sinatra::Base
  Dotenv.load
  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
    set views: proc { File.join(root, '../views/') }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  register Sinatra::Namespace
  helpers ViewHelper
  helpers UserHelper

  get '/' do
    @places = Place.all
    erb :home
  end
end
