require 'bundler'
Bundler.require(:default, :development)
Dir.glob('./{models,controllers,helpers}/*.rb').each { |file| require file }

set :database, adapter: 'sqlite3', database: ENV['BASE_PATH']
use Rack::MethodOverride

map('/') { run UserController }
