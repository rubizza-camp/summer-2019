require './controllers/application_controller.rb'
require './controllers/session_controller.rb'
require './controllers/shop_controller.rb'
require './controllers/review_controller.rb'

use SessionController
use ShopController
use ReviewController
run ApplicationController
