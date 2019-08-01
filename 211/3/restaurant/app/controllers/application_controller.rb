require './config/environment'

require_relative 'base_controller.rb'
require_relative 'restaurants_controller.rb'
require_relative 'reviews_controller.rb'
require_relative 'sessions_controller.rb'

class ApplicationController < BaseController
  use SessionsController
  use RestaurantsController
  use ReviewsController
end
