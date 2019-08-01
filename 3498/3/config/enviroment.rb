require 'bundler'
Bundler.require

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'food-rating.sqlite3'
)

require './app/controllers/application_controller.rb'
