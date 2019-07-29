require_relative 'config/environment'
require 'sinatra/strong-params'
use Rack::MethodOverride

map('/') { run CafeController }
