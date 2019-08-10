require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: ENV['ADAPTER'],
  database: ENV['DATA_BASE']
)
require_all 'app'
