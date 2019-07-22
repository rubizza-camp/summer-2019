require 'telegram/bot'
require 'redis'
require 'logger'
require 'byebug'
require 'pry'
require 'active_support/time'
require_relative 'commands/start'
require_relative 'commands/check_in'
require_relative 'commands/check_out'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include StartCommand
  include CheckInCommand
  include CheckOutCommand

  self.session_store = :redis_store, { expires_in: 1.month }
end

TOKEN = ENV['TELEGRAM_BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
