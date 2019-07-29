require_relative './commands/checkin_command.rb'
require_relative './commands/checkout_command.rb'
require_relative './commands/start_command.rb'
require_relative './helpers/photo_helper.rb'

# class to start bot
class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store,
                                                   { expires_in: 2_592_000 }
  include Telegram::Bot::UpdatesController::MessageContext
  include PhotoHelper
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
end
