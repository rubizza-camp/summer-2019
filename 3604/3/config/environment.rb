require 'bundler'
Bundler.require
require 'rack-flash'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'foo.sqlite3'
)

require_all 'application'
