ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "food-rating.sqlite3"
)

require './app/controllers/application_controller.rb'
