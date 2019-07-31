# frozen_string_literal: true

require 'sinatra'
require 'rubygems'
require 'sinatra/activerecord'
require 'erb'
require 'sinatra/flash'
require 'dotenv'
require 'require_all'
require_rel '../models/'

require_relative 'restaurant_controller'
require_relative 'user_controller'

class AppController < Sinatra::Base
  Dotenv.load
  configure do
    enable :sessions
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :session_secret, ENV['key']
  end

  use UserController
  use RestaurantController
end
