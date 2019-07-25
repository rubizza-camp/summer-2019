require 'telegram/bot'
require 'logger'
require './webhooks_controller.rb'

TIME_TO_LIVE_SESSION = 2_592_000

Dotenv.load
TOKEN = ENV['TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)
controller = WebhooksController
logger = Logger.new(STDOUT)

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: TIME_TO_LIVE_SESSION }

poller = Telegram::Bot::UpdatesPoller.new(bot, controller, logger: logger)
poller.start
