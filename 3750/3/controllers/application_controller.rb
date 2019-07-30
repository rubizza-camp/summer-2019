# frozen_string_literal: true

require 'sinatra/flash'
require 'truemail'
require_relative 'base_controller'
require_relative 'session_controller'
require_relative 'restaurant_controller'
require_relative 'review_controller'
require_relative 'website_controller'

class ApplicationController < BaseController
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  use WebsiteController
  use SessionController
  use RestaurantController
  use ReviewController
end
