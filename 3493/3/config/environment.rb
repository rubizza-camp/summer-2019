require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'sinatra/flash'
require 'sinatra/strong-params'
require 'pagy'
require 'pagy/extras/bootstrap'
require 'bcrypt'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

set :database, adapter: 'sqlite3', database: ENV['DATABASE']
