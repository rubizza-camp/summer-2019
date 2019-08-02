# frozen_string_literal: true

require './config/environment'
# use Rack::Static, urls: ['/css'], root: 'public' # Rack fix allows seeing the css folder.
use UserController
use RestaurantController
run AppController
