require 'active_support/time'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include I18n

  include Start
  include Checkin
  include Checkout

  self.session_store = :redis_store, { expires_in: 1.month }

  def chat_session
    @chat_session ||= self.class.build_session('bot_session')
  end

  def process_action(*)
    super
  ensure
    chat_session.commit
  end
end
