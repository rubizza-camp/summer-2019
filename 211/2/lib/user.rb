require 'open-uri'
require 'fileutils'

class User
  attr_accessor :rubizza_number, :status, :user_id
  def initialize(user_id)
    @user_id = user_id
  end

  def change_status(message)
    case message.text
    when '/checkin'
      return gimme_id unless REDIS.get(message.chat.id)

      @status = 'checkins'
    when '/checkout'
      puts @status = 'chekouts'
    end
    REDIS.set("#{@user_id}_status", @status)
    ask_selfie
  end

  def gimme_id
    { chat_id: @user_id, text: 'gimme your id' }
  end

  def ask_selfie
    { chat_id: @user_id, text: ' selfie pls' }
  end
end
