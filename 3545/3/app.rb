require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'csv'
require './models.rb'
require 'bcrypt'

set :database, 'sqlite3:project-name.sqlite3'
