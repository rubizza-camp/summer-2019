# frozen_string_literal: true

require 'redis'
require './identifiers'

# :nodoc:
module CheckNumber
  include Identifiers
  def start!(*)
    if registred?
      respond_with :message, text: 'You have already registered! Tap /checkin to continue'
    else
      save_context :register_from_message
      respond_with :message, text: 'Please, enter your own Rubizza-number'
    end
  end

  def register_from_message(*words)
    respond_with :message, text: add_number(words)
  end

  private

  def add_number(number)
    redis = Redis.new
    check_registaration(redis, number.first.to_i)
  end

  def check_registaration(redis, number)
    return 'You have already registred' if redis.get(number) || session.key?(:number)
    return 'Non existent Rubizza-number. Tap /start and try again' if !member?(number)
    session[:number] = number
    redis.set(number, user_id)
    'Successfully registered. Enter /checkin to continue'
  end

  def members
    @members ||= YAML.load_file('members.yml')['members']
  end

  def member?(number)
    members.include?(number)
  end
end
