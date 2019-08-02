require 'bundler'
Bundler.require

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ENV['DB_PATH']
)

Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }
