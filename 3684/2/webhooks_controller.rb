class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include ContextMessages
  include InfoSaver

  self.session_store = :redis_store, { expires_in: 1_000_000_000_000 }

  def message
    reply_with :message, text: 'Шо ты несешь, чувырло?'
  end
end
