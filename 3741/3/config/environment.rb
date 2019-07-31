# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'place_ranker.sqlite3'
)

Dir[File.join(File.dirname(__FILE__),
              '../models', '*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__),
              '../controllers', '*.rb')].each { |f| require f }
