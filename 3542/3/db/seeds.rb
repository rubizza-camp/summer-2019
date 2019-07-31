require 'active_record'
Dir['./models/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: 'db/development.sqlite3',
                                        pool: 15,
                                        timeout: 5000)

Place.find_or_create_by(name: 'Rubizza',
                        address: 'Masherova, 11',
                        description: 'Extremal ruby courses')

Place.find_or_create_by(name: 'Test',
                        address: 'Masherova, 11',
                        description: 'Test description')
