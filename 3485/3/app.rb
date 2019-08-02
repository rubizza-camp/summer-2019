require 'bundler'
require_relative 'models/restaurant'
require_relative 'models/user'
require_relative 'models/comment'

Bundler.require

set :database, adapter: 'sqlite3', database: '3.sqlite3'
