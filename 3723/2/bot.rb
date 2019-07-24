require 'logger'
require 'telegram/bot'
require 'redis'
require 'dotenv/load'
require_relative 'start'
require_relative 'numbers'
require_relative 'checkin'
require_relative 'checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include StartCommand
  include CheckinCommand
  include CheckoutCommand

  self.session_store = :redis_store, { expires_in: 1.hour }

  private

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end

TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
