require 'telegram/bot'
require 'active_support/time'
require_relative '../lib/datauser'
require_relative '../lib/downloader'
require_relative '../lib/saver'
require_relative '../lib/commands/check'
require_relative '../lib/commands/start'

class WebhooksController < Telegram::Bot::UpdatesController

  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include Saver
  include Downloader
  include ReceivePhotoAndLocation
  include Start
  include Check

  self.session_store = :redis_store, { expires_in: 1.month }

  def message(*)
    reply_with :message, text: 'What you mean?'
  end

end
