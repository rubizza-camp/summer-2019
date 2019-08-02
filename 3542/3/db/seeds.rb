require 'active_record'
require 'csv'
Dir['./models/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: 'db/development.sqlite3',
                                        pool: 15,
                                        timeout: 5000)

NAME = 0
ADDRESS = 1
DESCRIPTION = 2

CSV.foreach(File.realpath('db/data/data.csv')) do |row|
  Place
    .find_or_create_by(name: row[NAME], address: row[ADDRESS])
    .update(description: row[DESCRIPTION])
end
