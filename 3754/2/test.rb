require 'telegram/bot'
require 'active_support/all'
require 'redis'
require 'dotenv/load'
require 'yaml'
require 'net/http'
require 'json'
require 'fileutils'
require 'time'
require 'bundler'
require_relative './lib/webhooks_controller.rb'
require_relative './lib/database.rb'

Telegram::Bot::UpdatesController.session_store = :redis_store, {expires_in: 1.year}

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
