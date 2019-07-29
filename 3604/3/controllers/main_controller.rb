require 'sinatra'
require 'sinatra/activerecord'
require './models/place.rb'

Dir[File.join(__dir__, '.', '*.rb')].each { |file| require_relative file }

set(database: { adapter: 'sqlite3', database: 'foo.sqlite3' })

class MainController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  set public_folder: proc { File.join(root, '../public/') }

  get '/main' do
    @places = Place.all
    erb :main
  end

  use UserController
end
