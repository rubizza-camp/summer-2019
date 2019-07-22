require 'open-uri'
require 'yaml'
require_relative './status.rb'

class User
  include Answers
  include StatusChanger

  attr_accessor :rubizza_number, :status, :user_id

  def initialize(message)
    @message = message
    @user_id = message.chat.id
    @rubizza_id = REDIS.get(@message.chat.id)
  end

  def check_registration
    REDIS.get(@message.chat.id) ? help : gimme_id
  end

  def registration(rubizza_id)
    if (id = REDIS.get(@message.chat.id))
      { chat_id: @message.chat.id, text: "We already know each other, #{id}" }
    else
      numbers = YAML.load_file('data/rubizza_numbers.yml')['numbers']
      numbers.any?(rubizza_id) ? wellcome : try_again
    end
  end

  def change_status(message)
    check_status
    case message.text
    when @current
      return { chat_id: @user_id, text: "you already did your #{@current}" }
    when '/checkin', '/checkout'
      @status = message.text.tr('/', '') + 's'
    end
    REDIS.set("#{@user_id}_status", @status)
    ask_selfie
  end

  def check_status
    current_status = REDIS.get("#{@user_id}_status")
    @current = case current_status
               when 'checkined'
                 '/checkin'
               when 'checkouted'
                 '/checkout'
               end
  end

  def wellcome
    REDIS.set(@message.chat.id, @message.text)
    @rubizza_id = REDIS.get(@message.chat.id)
    help
  end

  def answer_to_request
    case @message.text
    when '/start'
      start
      check_registration
    when '/checkin'
      checking_in
    when '/checkout'
      checking_out
    when /\d/
      registration(@message.text.to_i)
    else
      help
    end
  end

  def checking_in
    status = REDIS.get("#{@user_id}_status")
    if %w[checkouted started].include?(status)
      waiting_for_photo(@message.text)
      ask_selfie
    else
      { chat_id: @message.chat.id, text: 'Nope. You cant checkin' }
    end
  end

  def checking_out
    status = REDIS.get("#{@user_id}_status")
    if status == 'checkined'
      waiting_for_photo(@message.text)
      ask_selfie
    else
      { chat_id: @message.chat.id, text: 'Nope. You cant checkout' }
    end
  end
end
