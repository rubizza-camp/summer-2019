require 'telegram/bot'
require 'logger'
require 'i18n'
require_relative 'controller'

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }

I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']

TOKEN = ENV['BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
