# frozen_string_literal: true

require 'bundler/setup'

Bundler.require
require 'sinatra/json'

set :database, adapter: 'sqlite3', database: 'places.sqlite3'

Dir.glob('./{models,controllers}/*.rb').each { |file| require file }
