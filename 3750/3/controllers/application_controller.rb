require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/flash'
require 'active_record'
require 'yaml/store'
require 'securerandom'
require 'truemail'
require_relative 'base_controller'
require_relative 'sessions_controller'
require_relative 'restaurant_controller'

class ApplicationController < BaseController
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  get '/' do
    @restaurants = Restaurant.all
    erb :home
  end

  use SessionsController
  use RestaurantController
end