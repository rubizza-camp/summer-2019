require 'sinatra/base'
require 'active_record'
require 'sinatra/flash'
Dir['./helpers/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
Dir['./controllers/*.rb'].each { |file| require file }
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: 'db/development.sqlite3',
                                        pool: 15,
                                        timeout: 5000)

class App < Sinatra::Base
  use ApplicationController
  use HomePagesController
  use SessionsController
  use PlacesController
  use CommentsController

  enable :sessions

  run!
end
