require 'telegram/bot'
require 'logger'
require 'ohm'
require 'redis'
require 'active_support/all'
require_relative 'start.rb'
require_relative 'checkin.rb'

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include Start
  include Checkin

  Ohm.redis = Redic.new("redis://127.0.0.1:6379")
end

TOKEN = ENV['BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start