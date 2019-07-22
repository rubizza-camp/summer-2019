require 'bundler'
require 'telegram/bot'
require 'time'
require 'yaml'
require 'active_support/all'
require 'json'
require 'net/http'
require 'ohm'
require 'dotenv'

require_relative './commands/start_command/start.rb'
require_relative './commands/checkin_command/checkin.rb'
require_relative './commands/checkout_command/checkout.rb'
require_relative './lib/dir_creator.rb'
require_relative './lib/webhook_controller.rb'
Dotenv.load
Ohm.redis = Redic.new(ENV['LINK'])
Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.year }

TOKEN = ENV['TOKEN'].freeze
bot = Telegram::Bot::Client.new(TOKEN)
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
