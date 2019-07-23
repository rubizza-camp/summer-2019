# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'data', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include DeleteCommand
  include Helper
end
