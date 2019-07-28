require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'sinatra/flash'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

set :database, adapter: 'sqlite3', database: 'mywebapp.sqlite3'
use Rack::MethodOverride

map('/') { run CafeController }
