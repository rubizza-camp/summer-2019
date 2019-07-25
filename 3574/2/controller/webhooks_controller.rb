require_relative '../commands/command_start'
require_relative '../commands/command_checkin'
require_relative '../commands/command_checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Telegram::Bot::UpdatesController::MessageContext
end
