# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
require './modules/start_command.rb'
require './modules/checkin_command.rb'
require './modules/checkout_command.rb'
require './modules/delete_command.rb'
require './modules/helper_with_methods.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include DeleteCommand
  include HelperWithMethods
end

bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
