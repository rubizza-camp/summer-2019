# frozen_string_literal: true

require 'telegram/bot'
require 'yaml'
require './commands/check_number'
require './commands/checkin'
require './commands/checkout'
require 'dotenv'
require 'json'
Dotenv.load

# :nodoc:
class WebhooksController < Telegram::Bot::UpdatesController
  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 8_888_888 }
  end

  include Telegram::Bot::UpdatesController::MessageContext

  include CheckNumber
  include Checkin
  include Checkout
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
