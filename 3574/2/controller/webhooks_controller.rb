require_relative '../commands/start_command'
require_relative '../commands/checkin_command'
require_relative '../commands/checkout_command'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include LocationHelper
  include PhotoHelper
  include SaveHelper
  include Telegram::Bot::UpdatesController::MessageContext
end
