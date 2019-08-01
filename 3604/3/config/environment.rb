require 'bundler'
Bundler.require
require 'rack-flash'

environment = ENV.fetch('RACK_ENV', 'development')

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "places_minsk_#{environment}.sqlite3"
)

require_all 'application'
