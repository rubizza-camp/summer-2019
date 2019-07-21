# frozen_string_literal: true

require_relative 'telegram_exception'
module BaseCommandHelpers
  private

  def already_registered?
    session.key?(:number)
  end

  def not_registered?
    !session.key?(:number)
  end

  def checked_out?
    !session[:checkin]
  end

  def checked_in?
    session[:checkin]
  end

  def user_id
    id = payload.fetch('from', {}).fetch('id', TelegramException::ERR_MSG)
    raise Telegram if id == TelegramException::ERR_MSG

    id
  end

  def stop_message
    respond_with :message, text: 'You are registered already, stop it' if session.key?(:number)
  end

  def register_message
    respond_with :message, text: 'You should register first!' unless session.key?(:number)
  end

  def checkin_message
    respond_with :message, text: 'You should checkin first!' unless session[:checkin]
  end

  def checkout_message
    respond_with :message, text: 'You should checkout first!' if session[:checkin]
  end

  def rescue_telegram
    respond_with :message, text: 'Oh no! Looks like Telegram servers are broken. Try again later'
  end
end
