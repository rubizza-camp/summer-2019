require 'open-uri'
require 'yaml'
require_relative './status.rb'

class User
  include Answers
  include StatusChanger

  def initialize(message)
    @message = message
    @user_id = message.chat.id
  end

  def check_registration
    if REDIS.get(user_id)
      start
      help
    else
      gimme_id
    end
  end

  def registration(rubizza_id)
    numbers = YAML.load_file('data/rubizza_numbers.yml')['numbers']
    numbers.any?(rubizza_id) ? wellcome : try_again
  end

  def change_status(message, current)
    check_status
    case message.text
    when current
      "you already did your #{current}"
    when '/checkin', '/checkout'
      status = message.text.tr('/', '') + 's'
    end
    REDIS.set("#{user_id}_status", status)
    ask_selfie
  end

  def check_status
    current_status = REDIS.get("#{user_id}_status")
    current = case current_status
               when 'checkined'
                 '/checkin'
               when 'checkouted'
                 '/checkout'
               end
  end

  def wellcome
    REDIS.set(user_id, message.text)
    start
    help
  end

  # rubocop: disable Metrics/MethodLength
  def answer_to_request
    case message.text
    when '/start'
      check_registration
    when '/checkin'
      checking_in
    when '/checkout'
      checking_out
    when /\d/
      if REDIS.get(user_id)
        help
      else
        registration(message.text.to_i)
      end
    else
      help
    end
  end
  # rubocop: enable Metrics/MethodLength

  def checking_in
    status = REDIS.get("#{user_id}_status")
    if %w[checkouted started].include?(status)
      waiting_for_photo(message.text)
      ask_selfie
    else
      'Nope. You cant checkin'
    end
  end

  def checking_out
    status = REDIS.get("#{user_id}_status")
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
