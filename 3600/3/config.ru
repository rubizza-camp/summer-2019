# frozen_string_literal: true

require './config/environment'
use UserController
use RestaurantController
run AppController
