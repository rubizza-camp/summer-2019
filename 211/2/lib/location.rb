require 'fileutils'

class LocationHelper
  attr_reader :bot, :message, :user_id, :latitude, :longitude, :photo

  def initialize(bot, message, user_id, photo)
    @bot = bot
    @message = message
    @user_id = user_id
    @latitude =  message.location.latitude
    @longitude = message.location.longitude
    @photo = photo
  end

  def call(status)
    if check_status == 'checkined' || check_status == 'checkouted'
      return { chat_id: message.chat.id, text: 'Stop Spam at me' }
    end
    create_folder(status)

    begin @photo.save_img(status, @timestamp)
          save_location(status)
          puts  REDIS.get("#{@user_id}_status")
          REDIS.set("#{@user_id}_status", status.gsub(/s$/, 'ed'))
          puts  REDIS.get("#{@user_id}_status")
          { chat_id: message.chat.id, text: 'Nice to see you in right place' }
    rescue NoMethodError
      FileUtils.rm_rf("#{user_id}/#{status}/#{@timestamp}")
      ask_photo
    end
  end

  def create_folder(status)
    puts @timestamp = Time.now.getlocal('+03:00').to_i
    FileUtils.mkdir_p("#{user_id}/#{status}/#{@timestamp}")
  end

  def save_location(status)
    loc = "#{@latitude}, #{@longitude}"
    File.write("#{user_id}/#{status}/#{@timestamp}/location.txt", loc)
  end

  def check_status
    current_status = REDIS.get("#{@user_id}_status")
  end

  def ask_photo
    { chat_id: message.chat.id, text: 'Need to see your photo first' }
  end
end
