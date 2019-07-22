require_relative '../commands/start'
require_relative '../commands/checkin'
require_relative '../commands/checkout'
require_relative '../commands/logout'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include LogoutCommand
  include Telegram::Bot::UpdatesController::MessageContext
end
