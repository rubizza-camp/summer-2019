require 'telegram/bot'
require 'logger'
require 'redis'
require 'active_support/all'
require 'fileutils'
require 'open-uri'
require 'json'
require 'time'
require 'yaml'
require_relative 'file_accessor'
require_relative 'webhooks_controller'
require_relative 'storage'

TOKEN = ENV['BOT_TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)
controller = WebhooksController
logger = Logger.new(STDOUT)

poller = Telegram::Bot::UpdatesPoller.new(bot, controller, logger: logger)
poller.start
