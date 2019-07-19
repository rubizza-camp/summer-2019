require_relative './photo.rb'
require_relative './message.rb'
require_relative './location.rb'
require_relative './user.rb'

class Router
  def self.evaluate(message, bot)
    message_helper = MessageHelper.new(bot, message)
    puts @user = User.new(message.chat.id)

    if message_helper.is_a_photo?
      puts 'its a photo'
      @photo = PhotoHelper.new(message, bot, TOKEN, message.from.id)
      @photo.call(RRRRedis.get("#{@user.user_id}_status"))
      # photo_helper = PhotoHelper.new(bot, TOKEN, message.from.id).call
      # url = photo_helper.image_url
      # # создать объект фото с id и сказать, что есть сегодняшнее
      # puts url 
      # puts RRRRedis.get(:time)
      # bot.api.send_message(chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?")
      # {chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?"}
    elsif message_helper.is_location?
      LocationHelper.new(bot, message, message.from.id, @photo).call(RRRRedis.get("#{@user.user_id}_status"))
      # puts location = LocationHelper.new(bot, message, message.from.id).call
      # p lat = location.latitude
      # p lon = location.longitude
      { chat_id: message.chat.id, text: "nice"}
    elsif message_helper
      case message.text
      when '/start'
        puts message.from.first_name
        # bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        
        {chat_id: message.chat.id, text: "Hello, #{message.from.first_name}"}
      when '/checkin'
        if RRRRedis.get(message.chat.id)
          
          # bot.api.send_message(chat_id: message.chat.id, text: "#{message.from.first_name}, selfie pls")
          puts @user.status 
          @user.change_status(message)
          # {chat_id: message.chat.id, text: "#{message.from.first_name}, selfie pls"}
        else 
          # bot.api.send_message(chat_id: message.chat.id, text: "#{message.from.first_name}, enter your id")
          {chat_id: message.chat.id, text: "#{message.from.first_name}, enter your id"}
        end
      when '/checkout'
        # bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        @user.change_status(message)
      when (/\d/)
        puts 'maybe its id'
        RRRRedis.set(message.chat.id, message.text)
        @user.rubizza_number = message.text

        {chat_id: message.chat.id, text: "Hi, #{@user.rubizza_number} "}
        # {chat_id: message.chat.id, text: "Hi "}
      else
        if message.location.nil?
          # bot.api.send_message(chat_id: message.chat.id, text: "Gimme location, moterfucker!")
          {chat_id: message.chat.id, text: "Gimme location, moterfucker!"}
        end
      end
   end #first if
 end
end