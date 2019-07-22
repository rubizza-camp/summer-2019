# frozen_string_literal: true

require_relative '../helpers/base_command_helpers'

module StartCommand
  include BaseCommandHelpers

  def start!(*)
    if already_registered?
      stop_message
      return
    end
    save_context :try_register
    respond_with :message, text: 'What is your number?'
  end

  def try_register(*words)
    respond_with :message, text: write_session_register(words)
  rescue ParseHashException
    rescue_number
  rescue TelegramException
    rescue_telegram
  end

  private

  def numbers
    @numbers ||= self.class.numbers
  end

  def reversed_redis
    @reversed_redis ||= self.class.redis
  end

  def write_session_register(number = nil, *)
    number = number.first.to_i
    registration_check_text(number)
  end

  def registration_check_text(number)
    if reversed_redis.get(number) || session.key?(:number)
      'You have already registered, stop it'
    elsif validate_number(number)
      register_user(number)
      'Registration done!'
    else
      'No such number! Input another'
    end
  end

  def register_user(number)
    session[:number] = number
    reversed_redis.set(number, user_id)
  end

  def rescue_number
    save_context :try_register
    respond_with :message, text: 'Are you sure you sent a number? Try again later'
  end
end
