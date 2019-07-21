class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include Checkout
  include Checkin
  include Start
  include DownloadPhoto
  include FileManager
  include ReceivePhotoAndLocation

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_250_000 }

  def message(*)
    reply_with :message, text: 'Я такого не знаю ?'
  end
end
