require 'ohm'
require 'logger'
require 'telegram/bot'
require 'active_support/all'
require 'yaml'

require_relative 'webhooks_controller'

logger = Logger.new(STDOUT)

BOT_TOKEN = ENV['BOT_TOKEN']
STUDENT_NUMBERS = YAML.load_file('numbers.yml')['numbers']

Ohm.redis = Redic.new('redis://127.0.0.1:6379')

bot = Telegram::Bot::Client.new(BOT_TOKEN)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
