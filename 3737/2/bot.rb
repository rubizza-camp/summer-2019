require 'active_support/all'
require 'ohm'
require 'redis'
require 'telegram/bot'
require_relative './commands/checkin_command.rb'
require_relative './commands/checkout_command.rb'
require_relative './commands/start_command.rb'

Telegram::Bot::UpdatesController.session_store = :redis_store,
                                                 { expires_in: 1.month }

# class to start bot
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand

  Ohm.redis = Redic.new('redis://127.0.0.1:6379')
end

TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController,
                                          logger: logger)
poller.start
