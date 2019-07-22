# frozen_string_literal: true

require 'telegram/bot'
require './commands/start'
require './commands/checkin'
require './commands/checkout'

# TOKEN = '984456161:AAFfF7jgKPNnZJ51auOVe1uVv_-6gxmifCs'
class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckInCommand
  include CheckOutCommand
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
  end
end

bot_token = ENV['BOT_TOKEN']
bot = Telegram::Bot::Client.new(bot_token)
# Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 3600 }

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
