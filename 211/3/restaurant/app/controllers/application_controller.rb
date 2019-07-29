require './config/environment'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/flash'

require_relative 'base_controller.rb'
require_relative 'sessions_controller.rb'
require_relative 'restaurants_controller.rb'
require_relative 'reviews_controller.rb'

class ApplicationController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  enable :sessions
  use Rack::Static, urls: ['/stylesheets', '/javascripts', '/images'], root: 'public'
  set :static, true

  use SessionsController
  use RestaurantsController
  use ReviewsController
end
