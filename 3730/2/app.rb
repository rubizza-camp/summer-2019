require 'telegram/bot'
require 'redis'
require 'yaml'
require 'time'
require './commands/start'
require './commands/check_in'
require './commands/check_out'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  self.session_store = :redis_store, { expires_in: 100_000 }

  include StartCommand
  include CheckInCommand
  include CheckOutCommand
end

TOKEN = ENV.fetch('BOT_TOKEN')
bot = Telegram::Bot::Client.new(TOKEN)
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
