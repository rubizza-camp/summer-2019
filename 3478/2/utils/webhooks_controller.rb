require_relative 'command/start_command.rb'
require_relative 'command/unlink_command.rb'
require_relative 'command/checkin_command.rb'
require_relative 'command/checkout_command.rb'
require_relative 'file_manager.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_250_000 }
  include Telegram::Bot::UpdatesController::MessageContext

  include StartCommand
  include Unlink
  include CheckoutCommand
  include CheckinCommand
end
