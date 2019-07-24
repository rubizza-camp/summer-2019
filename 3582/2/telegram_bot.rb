require 'telegram/bot'
require 'yaml'
require './commands/start_command'
require './commands/checkin_command'
require './commands/checkout_command'
require 'pry'
require 'redis-activesupport'
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand

  private

  def session_key
    from['id'] if from
  end
end

TOKEN = ENV['TELEGRAM_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)
Telegram::Bot::UpdatesController.session_store = :redis_store, 'https://127.0.0.1:6379', { expires_in: 1_000_000 } # rubocop:disable Metrics/LineLength

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
