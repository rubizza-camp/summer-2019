require 'telegram/bot'
require 'date'
require 'redis-rails'
require 'active_support/all'
require 'pry'
require 'redis'
require 'ohm'
require 'logger'
require_relative './commands/start_command/start.rb'
require_relative './commands/checkin_command/checkin.rb'
require_relative './commands/checkout_command/checkout.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  self.session_store = :redis_store, { expires_in: 2.month }
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  Ohm.redis = Redic.new('redis://127.0.0.1:6379')
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: Logger.new(STDOUT)).start
