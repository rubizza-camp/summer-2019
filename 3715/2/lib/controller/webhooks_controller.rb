require_relative '../helpers/base_command_helpers'
require_relative '../helpers/photo'
require_relative '../helpers/location'
require_relative '../helpers/sessions_helper'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include BaseCommandHelpers
  include SessionsHelper
  include Location
  include Telegram::Bot::UpdatesController::MessageContext

  self.session_store = :redis_store, { expires_in: 1.month }
end
