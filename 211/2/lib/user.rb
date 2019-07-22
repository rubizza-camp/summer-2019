require 'open-uri'
require 'yaml'

class User
  include Answers

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
    when '/checkin'
      @status = 'checkins'
    when '/checkout'
      @status = 'checkouts'
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
end
