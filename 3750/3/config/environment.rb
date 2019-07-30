require 'bundler/setup'
Bundler.require

ENV['DATABASE_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/#{ENV['DATABASE_ENV']}.sqlite3"
)

require_all 'controllers', 'models'
