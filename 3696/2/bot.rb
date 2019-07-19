# frozen_string_literal: true

require 'telegram/bot'
require './comands/start'
require './comands/checkin'
require './comands/checkout'
require 'date'
require 'logger'
class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Telegram::Bot::UpdatesController::MessageContext
  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
  end
end

bot = Telegram::Bot::Client.new(ENV.fetch('ACCESS_BOT_TOKEN'))
# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
