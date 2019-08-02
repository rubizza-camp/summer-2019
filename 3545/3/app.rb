require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require './models.rb'
require 'bcrypt'

set :database, 'sqlite3:project-name.sqlite3'
