class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1_000_000 }
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include BotStartCommands
  include BotCheckinCommands
  include BotCheckoutCommands

  use_session!
end
