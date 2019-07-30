# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  host: ENV['SQL_LITE_HOST'],
  database: ENV['SQL_LITE_DB_PATH']
)
