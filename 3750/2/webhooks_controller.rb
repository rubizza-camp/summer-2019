require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'contexts/geo_check'
require_relative 'contexts/photo_check'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  include ::Commands::Start
  include ::Commands::Checkin
  include ::Commands::Checkout

  include ::Contexts::PhotoCheck
  include ::Contexts::GeoCheck

  MSG = {
    success_registration: 'Registration done',
    failure: 'There is no such number in my list',
    already_registered: 'No need to register again',
    number_request: 'Hello! Tell me your Number',
    not_registered: "You got to register first.
    This will be easy, just type in /start command and I'll check your number in list",
    not_checked_out: 'You need to /checkout from current shift
    before you can /checkin in a new one',
    not_checked_in: 'You need to /checkin first',
    success_check_start: 'Show me yourself first',
    success_checkin_end: 'Your shift have successfully begun',
    success_checkout_end: 'I hope you worked well today. Have a nice day',
    farewell_sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag',
    photo_check_success: 'Good. Now i need your geolocation',
    photo_check_failure: "I don't see a photo here",
    geo_check_failure: "I don't see you in place"
  }.freeze

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }
  end

  def notify(msg_key)
    respond_with :message, text: MSG[msg_key]
  end

  def notify_with_reference(msg_key)
    reply_with :message, text: MSG[msg_key]
  end

  def send_sticker(msg_key)
    respond_with :sticker, sticker: MSG[msg_key]
  end

  def registered?
    session.key?(:number)
  end

  def checked_in?
    session[:checked_in]
  end

  def checked_out?
    !checked_in?
  end
end
