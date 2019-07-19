# frozen_string_literal: true

require 'telegram/bot'
require './comands/start'
require './comands/checkin'
require './comands/checkout'
require 'date'
class WebhooksController < Telegram::Bot::UpdatesController
  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
  end

  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Telegram::Bot::UpdatesController::MessageContext
end

bot = Telegram::Bot::Client.new(ENV.fetch('RUBIZZA_TOKEN'))
# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
