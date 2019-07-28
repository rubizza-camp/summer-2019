# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'logger'
require_relative 'controller/webhooks_controller'

MONTH = 2_592_000
REDIS = Redis.new

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: MONTH }
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
