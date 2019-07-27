require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'restaurant.sqlite3'
)

require_relative '../app/controllers/application_controller.rb'
Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }
