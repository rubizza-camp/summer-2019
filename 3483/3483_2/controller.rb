require 'ohm'
require 'redis'
require 'active_support/all'
require_relative './comands/start.rb'
require_relative './comands/checkin.rb'
require_relative './comands/checkout.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include I18n

  include Start
  include Checkin
  include Checkout

  REDIS_IP = ENV['REDIS_IP']

  Ohm.redis = Redic.new(REDIS_IP)
end
