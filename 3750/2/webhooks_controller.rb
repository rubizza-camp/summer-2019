require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'data_check'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  include ::Commands::Start
  include ::Commands::Checkin
  include ::Commands::Checkout

  include DataCheck

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
    return true if session.key?(:number)
    false
  end

  def checkin?
    return true if session[:checkin?]
    false
  end

  def checkout?
    return true if session[:checkout?]
    false
  end
end
