# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  host: ENV['SQL_LITE_HOST'],
  database: ENV['SQL_LITE_DB_PATH']
)

ActiveRecord::Schema.define do # rubocop:disable Metrics/BlockLength
  create_table :snack_bars do |table|
    table.column :telephone, :string
    table.column :working_time_opening, :string
    table.column :working_time_closing, :string
    table.column :latitude, :string
    table.column :longitude, :string
    table.column :user_id, :integer
    table.column :modular_raiting, :float
    table.column :comments_count, :integer
    table.column :description, :string
    table.column :name, :string
    table.column :photo, :string
  end

  create_table :feed_backs do |table|
    table.column :user_id, :integer
    table.column :snack_bar_id, :integer
    table.column :content, :string
    table.column :raiting, :float
    table.column :date, :datetime
  end

  create_table :users do |table|
    table.column :first_name, :string
    table.column :last_name, :string
    table.column :mail, :string
    table.column :password, :string
    table.column :session, :string
  end
end
