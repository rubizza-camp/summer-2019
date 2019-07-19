require 'telegram/bot'
require 'yaml'
require './commands/start'
require './commands/checkin'
require './commands/checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1_000_000 }
  end

  include Telegram::Bot::UpdatesController::MessageContext

  include StartCommand
  include CheckinCommand
  include CheckoutCommand
end

TOKEN = ENV.fetch('TG_BOT_TOKEN')
bot = Telegram::Bot::Client.new(TOKEN)
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
