# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require_relative './commands/start.rb'
require_relative './commands/checkin.rb'
require_relative './commands/checkout.rb'
require_relative './commands/helper.rb'
require 'logger'

#  Telegramm bot modules
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include Helper
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1_000_000 }
end

TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
