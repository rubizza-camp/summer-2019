# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require 'logger'
require 'active_support/all'
require 'redis-rails'
require 'csv'
require './commands/start'
require './commands/checkin'
require './commands/checkout'

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include StartCommand
  include CheckInCommand
  include CheckOutCommand

  use_session!
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
Dotenv.load
