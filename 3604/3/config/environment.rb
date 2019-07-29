require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'foo.sqlite3'
)

require_all 'application'
