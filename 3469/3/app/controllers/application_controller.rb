require 'sinatra'
require 'rubygems'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bcrypt'
require 'erb'
require 'email_address'
require 'dotenv'
require_relative './controller'
class AppController < Sinatra::Base
  Dotenv.load
  configure do
    enable :sessions
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :session_secret, ENV['key']
  end

  use Controller
end
