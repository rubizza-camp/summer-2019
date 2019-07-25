require 'telegram/bot'
require 'open-uri'
require 'active_support/time'
require_relative '../lib/commands/check'
require_relative '../lib/commands/start'
require_relative '../lib/geoposition'
require_relative '../lib/user_photo'
require_relative '../lib/saver'
require_relative '../lib/user_methods'
require_relative '../lib/validation/location'
require_relative '../lib/validation/number'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include UserStates
  include GeopositionCommand
  include Check
  include Start
  include UserPhoto
  include LocationValidation

  self.session_store = :redis_store, { expires_in: 1.month }

  def message(*)
    reply_with :message, text: 'What you mean?'
  end
end
