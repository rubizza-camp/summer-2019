# frozen_string_literal: true

require 'telegram/bot'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'helpers/memoization_helpers'

class WebhooksController < Telegram::Bot::UpdatesController
  extend MemoizationHelpers

  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Telegram::Bot::UpdatesController::MessageContext

  self.session_store = :redis_store, { expires_in: 2_592_000 }
end
