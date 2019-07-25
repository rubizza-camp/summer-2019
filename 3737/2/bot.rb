require 'logger'
require 'ohm'
require 'redis'
require 'telegram/bot'
require_relative 'webhook_controller.rb'

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

Ohm.redis = Redic.new('redis://127.0.0.1:6379')
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController,
                                          logger: logger)
poller.start
