require 'open-uri'
require 'yaml'

require_relative 'state_changer.rb'

class User
  include StateChanger

  def initialize(message)
    @message = message
    @user_id = message.chat.id
  end

  def starting
    if Redis.current.get(user_id)
      "Hi, #{Redis.current.get(user_id)}."\
    else
      'Give me your id'
    end
  end

  def checking_in
    state = Redis.current.get("#{user_id}_state")
    if %w[checkouted started].include?(state)
      waiting_for_photo(message.text)
      'Selfie, pls'
    else
      'Nope. You can\'t checkin'
    end
  end

  def checking_out
    state = Redis.current.get("#{user_id}_state")
    if state == 'checkined'
      waiting_for_photo(message.text)
      'Selfie, pls'
    else
      'Nope. You can\'t checkout'
    end
  end

  def registration(rubizza_id)
    numbers = YAML.load_file('data/rubizza_numbers.yml')['numbers']
    numbers.any?(rubizza_id) ? welcome : 'Try another number'
  end

  def welcome
    Redis.current.set(user_id, message.text)
    start
    help_message
  end

  def help_message
    'Type /checkin to checkin, '\
    '/checkout to checkout. '\
    'Sincerely yours, K.O.'\
  end

  private

  attr_reader :message, :user_id
end
