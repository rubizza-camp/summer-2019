# require 'sinatra'
# require 'sinatra/activerecord'
#
#
#
# set :database, "sqlite3:3.sqlite3"
#
#
# get '/' do
#   erb :home
# end
#
# get '/registration' do
#   erb :registration
# end
#
# get '/kfc' do
#   erb :kfc
# end
#
# get '/mc' do
#   erb :mc
# end
#
# get '/bk' do
#   erb :bk
# end

require 'bundler'
require_relative 'models/place'
require_relative 'models/users'
require_relative 'models/review'

Bundler.require

set :database, adapter: 'sqlite3', database: '3.sqlite3'
