# frozen_string_literal: true

require 'redis'
require 'yaml'
require './helpers/base_comand_helpers'
module StartCommand
  include BaseComandHelpers

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
  end

  def registration_check_text(redis, number)
    if redis.get(number) || session.key?(:number)
      'You are registered already, stop it'
    else
      return 'No such number!' unless validate_number(number)

      session[:number] = number
      redis.set(number, user_id)
      'Registration done!'
    end
  end

  def validate_number(number)
    numbers.include?(number)
  end

  def numbers
    @numbers ||= YAML.load_file(DATA_PATH)[NUMBERS_LIST_KEY].map(&:to_i)
  end
end
