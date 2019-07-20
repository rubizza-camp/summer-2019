# frozen_string_literal: true

require 'redis'
require 'yaml'
require './helpers/base_command_helpers'

module StartCommand
  include BaseCommandHelpers

  def start!(*)
    return if already_registered?

    save_context :register_message
    respond_with :message, text: 'What is your number?'
  end

  DATA_PATH = './data/numbers.yaml'
  NUMBERS_LIST_KEY = 'numbers'

  def register_message(*words)
    respond_with :message, text: write_session_register(words)
  end

  private

  def write_session_register(number = nil, *)
    reversed_redis = Redis.new
    number = number.first.to_i
    registration_check_text(reversed_redis, number)
  # Looks like it is never called, unless number is nil(and i can imagine this), but let it be
  rescue NoMethodError
    rescue_number
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

  def numbers
    @numbers ||= YAML.load_file(DATA_PATH)[NUMBERS_LIST_KEY].map(&:to_i)
  end

  def rescue_number
    save_context :register_message
    respond_with :message, text: 'Are you sure you sent a number?'
  end
end
