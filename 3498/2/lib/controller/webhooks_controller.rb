class WebhooksController < Telegram::Bot::UpdatesController
  SESSION_TIMELIFE = 1_000_000

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: SESSION_TIMELIFE }
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include BotStartCommands
  include BotCheckinCommands
  include BotCheckoutCommands

  use_session!

  def current_user
    User[session[:user_id]]
  end
end
