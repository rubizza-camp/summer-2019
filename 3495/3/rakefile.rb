require 'sinatra/activerecord/rake'
require 'bundler'
Bundler.require(:default, :development)
Dir.glob('./{models,controllers}/*.rb').each { |file| require file }

set :database, adapter: 'sqlite3', database: ENV['BASE_PATH']
use Rack::MethodOverride
