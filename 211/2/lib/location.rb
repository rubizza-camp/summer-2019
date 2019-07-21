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
    create_folder(status)

    begin @photo.save_img(status, @timestamp)
          save_location(status)
          REDIS.set("#{@user_id}_status", status.gsub(/s$/, 'ed'))
          { chat_id: message.chat.id, text: 'Nice to see you in right place' }
    rescue NoMethodError
      ask_photo
    end
  end

  def create_folder(status)
    @timestamp = Time.now.getlocal('+03:00').to_i
    FileUtils.mkdir_p("#{user_id}/#{status}/#{@timestamp}")
  end

  def save_location(status)
    loc = "#{@latitude}, #{@longitude}"
    File.write("#{user_id}/#{status}/#{@timestamp}/location.txt", loc)
  end

  def ask_photo
    { chat_id: message.chat.id, text: 'Need to see your photo first' }
  end
end
