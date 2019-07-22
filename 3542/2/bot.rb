require 'telegram/bot'
require 'logger'
require 'i18n'
require_relative 'bot_controller'

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']

TOKEN = ENV['BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
