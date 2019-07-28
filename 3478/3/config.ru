require_relative 'app/controllers/app_controller.rb'
# use Rack::Static, urls: ['/css'], root: 'public' # Rack fix allows seeing the css folder.
run AppController
