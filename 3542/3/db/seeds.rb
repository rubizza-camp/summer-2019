require 'active_record'
Dir['./models/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: 'db/development.sqlite3',
                                        pool: 15,
                                        timeout: 5000)

Place.first_or_create(name: 'Rubizza', address: 'Masherova, 11', description: 'Extremal ruby courses')
