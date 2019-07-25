class WebhooksController < Telegram::Bot::UpdatesController
  EXP_DATE = 1_000_000

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: EXP_DATE }
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include BotStartCommands
  include BotCheckinCommands
  include BotCheckoutCommands

  use_session!
end
