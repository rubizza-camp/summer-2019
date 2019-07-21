# frozen_string_literal: true

require 'redis'
require 'yaml'
require_relative '../helpers/base_command_helpers'

module StartCommand
  include BaseCommandHelpers

  def start!(*)
    if already_registered?
      stop_message
      return
    end
    save_context :register_message
    respond_with :message, text: 'What is your number?'
  end

  def register_message(*words)
    respond_with :message, text: write_session_register(words)
  rescue ParseHashException
    rescue_number
  rescue TelegramException
    rescue_telegram
  end

  private

  DATA_PATH = './data/numbers.yaml'
  NUMBERS_LIST_KEY = 'numbers'

  def numbers
    @numbers ||= YAML.load_file(DATA_PATH).fetch(NUMBERS_LIST_KEY, []).map(&:to_i)
  end

  def write_session_register(number = nil, *)
    reversed_redis = Redis.new
    number = number.first.to_i
    registration_check_text(reversed_redis, number)
  end

  def registration_check_text(redis, number)
    if redis.get(number) || session.key?(:number)
      'You have already registered, stop it'
    elsif validate_number(number)
      register_user(redis, number)
      'Registration done!'
    else
      'No such number! Input another'
    end
  end

  def register_user(redis, number)
    session[:number] = number
    redis.set(number, user_id)
  end

  def rescue_number
    save_context :register_message
    respond_with :message, text: 'Are you sure you sent a number? Try again later'
  end
end
