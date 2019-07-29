# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  host: 'localhost',
  database: 'c:\sqlite\testDB.db'
)
