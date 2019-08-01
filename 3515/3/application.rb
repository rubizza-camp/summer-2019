require 'sinatra/activerecord'
require 'sinatra'
require 'pundit'
require 'pry'
require_relative 'models/models'

set :database_file, 'db/config/database.yml'
enable :sessions

get '/' do
  # binding.pry
  erb :home
end

# Restaurant.find_by(id:1).name
# Restaurant.all.first.attributes.values
# Restaurant.all.first.read_attribute(:name)
