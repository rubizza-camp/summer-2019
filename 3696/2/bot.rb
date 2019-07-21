# frozen_string_literal: true

require 'telegram/bot'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'

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
