# frozen_string_literal: true

require 'telegram/bot'
require './commands/start'
require './commands/checkin'
require './commands/checkout'

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
