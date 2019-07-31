# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'dotenv'
require_relative './commands/start'
require_relative './commands/checkin'
require_relative './commands/checkout'

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 3_000_000 }

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
end

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
