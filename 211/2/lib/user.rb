require 'open-uri'
require 'yaml'

class User
  attr_accessor :rubizza_number, :status, :user_id

  def initialize(message)
    @message = message
    @user_id = message.chat.id
  end

  def check_registration
    (rubizza_id = REDIS.get(@message.chat.id)) ? { chat_id: @message.chat.id, text: "Hi, #{rubizza_id}. Time to /checkin" } : gimme_id
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
    { chat_id: @message.chat.id, text: "Hi, #{@message.text}. Time to /checkin" }
  end

  def try_again
    { chat_id: @message.chat.id, text: 'Try another number' }
  end

  def gimme_id
    { chat_id: @user_id, text: 'gimme your id' }
  end

  def ask_selfie
    { chat_id: @user_id, text: ' selfie pls' }
  end
end
