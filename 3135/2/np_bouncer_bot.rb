require 'telegram/bot'
require 'redis'

#require 'open-uri'
#require_relative 'UserData_class'
require_relative 'UserInfo_class'
require_relative 'event_handler.rb'

redis = Redis.new(host: 'localhost')
token = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    #user = UserData.new(message.from.id, redis)
    tg_id = message.from.id
    user = UserInfo.new(redis, tg_id)

    case message.text
    when '/start'
      start(bot, message, user)
    when /^\d+$/
      save_camp_num(bot, message, user)
=begin
    when '/checkin'
      checkin(bot, message, user)
    when '/checkout'
      checkout(bot, message, user)
=end
    when '/status'
      puts user.action.what?
      puts user.request.what?
      #bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      #puts '/stop message received'
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (main switch)')  
    end
=begin
    else
      case
      when message.photo.any?
        photo(bot, message, user, token)

        # large_file_id = message.photo.last.file_id

        # file = bot.api.get_file(file_id: large_file_id)
        # file_path = file.dig('result', 'file_path')
        # uri = "https://api.telegram.org/file/bot#{token}/#{file_path}"

        # File.open('photo.jpeg', 'wb') do |file|
        #   file.write(open(uri).read)

      when message.location 
        location(bot, message, user)
      else
        bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (main switch)')  
      end
=end
  end
end