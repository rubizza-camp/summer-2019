ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/restoapp.sqlite3'
)

require './app/controllers/application_controller'
require_all 'app'
