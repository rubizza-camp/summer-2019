class WebhooksController < Telegram::Bot::UpdatesController
  self.session_store = :redis_store, { expires_in: 1.month }

  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  include CheckCommands
  include StartCommand
end
