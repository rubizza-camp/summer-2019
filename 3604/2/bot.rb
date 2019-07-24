require 'telegram/bot'
require 'logger'
require_relative 'webhooks_controller.rb'

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
