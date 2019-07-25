require 'bundler/setup'
Bundler.require

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/user_auth#{ENV['SINATRA_ENV']}.sqlite"
)

Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '../app/controllers', '*.rb')].each { |f| require f }
