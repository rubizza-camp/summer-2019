require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/session'
require 'truemail'
require './models/user'
require './models/shop'
require './models/review'

set :database, 'sqlite3:users.sqlite3'
class ApplicationController < Sinatra::Base
  register Sinatra::Session
  configure do
    set :views, 'views'
    enable :sessions
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end
end
