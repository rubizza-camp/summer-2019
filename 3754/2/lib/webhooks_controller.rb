require_relative '../commands/start_command.rb'
require_relative '../commands/checkin_command.rb'
require_relative '../commands/checkout_command.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
end
