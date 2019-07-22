require 'open-uri'
require 'fileutils'
require 'json'
require 'telegram/bot'
require 'redis'
require 'yaml'
require_relative 'controller/webhooks_controller'

ONE_MONTH = 2_592_000
REDIS = Redis.new

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.5 * ONE_MONTH }

bot = Telegram::Bot::Client.new(ENV['BOT_TOKEN'])

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
