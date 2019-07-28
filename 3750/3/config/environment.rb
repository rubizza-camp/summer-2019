require 'bundler/setup'
Bundler.require

ENV['DATABASE_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/best_taste.sqlite3'
)

Dir[File.join(File.dirname(__FILE__), '../models', '*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '../controllers', '*.rb')].each { |f| require f }
