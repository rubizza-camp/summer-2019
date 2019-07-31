require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'active_record'
require 'sinatra/flash'

Dir.glob('./app/models/*.rb').each { |file| require file }
Dir.glob('./app/controllers/*.rb').each { |file| require file }

set :database, adapter: 'sqlite3', database: 'development.sqlite3'

map('/') { run ApplicationController }
