require 'bundler'
require 'telegram/bot'
require 'time'
require 'yaml'
require 'active_support/all'
require 'json'
require 'net/http'
require 'ohm'
require 'dotenv'
require 'redis'
require 'redis-store'
require 'redis-activesupport'
require_relative './commands/start_command/start.rb'
require_relative './commands/checkin_command/checkin.rb'
require_relative './commands/checkout_command/checkout.rb'
require_relative './lib/dir_creator.rb'
Dotenv.load
Ohm.redis = Redic.new('redis://127.0.0.1:6379')
Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.year }
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
end

TOKEN = ('886244897:AAE8balNKJ7Nukdam2v3AuhiAhxCyRysVBs')
bot = Telegram::Bot::Client.new(TOKEN)
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
