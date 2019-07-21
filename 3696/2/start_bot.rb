require 'logger'
require 'telegram/bot'
require_relative 'bot.rb'

bot = Telegram::Bot::Client.new(ENV.fetch('ACCESS_BOT_TOKEN'))
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
