require 'sinatra'
require 'rubygems'
require 'sinatra/activerecord'
require 'email_address'
require 'erb'
require 'sinatra/flash'
require 'dotenv'
require 'truemail'
require 'pry'

require_relative '../models/users'
require_relative '../models/restaurants'
require_relative '../models/comments'

require_relative 'restaurant_controller'
require_relative 'user_controller'

class AppController < Sinatra::Base
  Dotenv.load
  configure do
    enable :sessions
    set :session_secret, ENV['key']
  end

  Truemail.configure do |config|
    config.verifier_email = 'ojiknpe@net8mail.com'
  end

  get '/test' do
    binding.pry
  end

  use UserController
  use RestaurantController
end