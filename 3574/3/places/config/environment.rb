require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ENV['DB']
)

require_all 'app'
