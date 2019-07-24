require 'telegram/bot'
require 'open-uri'
require 'active_support/time'
require_relative '../lib/commands/check'
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
  include UserPhoto
  include LocationValidation

  self.session_store = :redis_store, { expires_in: 1.month }

  def message(*)
    reply_with :message, text: 'What you mean?'
  end

  def start!(*)
    if UserStates.already_registered?(from['id'])
      respond_with :message, text: 'You are already registered'
    else
      respond_with :message, text: 'Enter the number'
      save_context :user_number
    end
  end

  def user_number(person_number = nil, *)
    if UserStates.find_user(person_number).empty? && NumberMethods.valid_number?(person_number)
      UserStates.create_user(from['id'], from['firts_name'], person_number)
      respond_with :message, text: 'Registration is successful'
    else
      respond_with :message, text: 'Wrong number'
      save_context :start!
    end
  end
end
