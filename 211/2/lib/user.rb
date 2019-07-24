require 'open-uri'
require 'yaml'

require_relative 'answers.rb'
require_relative 'status.rb'

class User
  include Answers
  include StatusChanger

  def initialize(message)
    @message = message
    @user_id = message.chat.id
  end

  def registration(rubizza_id)
    numbers = YAML.load_file('data/rubizza_numbers.yml')['numbers']
    numbers.any?(rubizza_id) ? wellcome : try_again
  end

  def wellcome
    Settings.redis.set(user_id, message.text)
    start
    help
  end

  def answer_to_request
    case message.text
    when '/start' then starting
    when '/checkin' then checking_in
    when '/checkout' then checking_out
    when /\d/
      Settings.redis.get(user_id) ? help : registration(message.text.to_i)
    else help
    end
  end

  def starting
    if Settings.redis.get(user_id)
      "Hi, #{Settings.redis.get(user_id)}."\
      "#{help}"
    else
      gimme_id
    end
  end

  def checking_in
    status = Settings.redis.get("#{user_id}_status")
    if %w[checkouted started].include?(status)
      waiting_for_photo(message.text)
      ask_selfie
    else
      'Nope. You cant checkin'
    end
  end

  def checking_out
    status = Settings.redis.get("#{user_id}_status")
    if status == 'checkined'
      waiting_for_photo(message.text)
      ask_selfie
    else
      'Nope. You cant checkout'
    end
  end

  private

  attr_reader :message, :user_id
end
