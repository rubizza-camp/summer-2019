require 'telegram/bot'
#require 'redis'
#require 'open-uri'
require_relative 'UserData_class'
require_relative 'event_handler.rb'

#RedisDB0 = Redis.new(host: 'localhost')
#List = [3135, 111]

token = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|

      user = UserData.new(message.from.id)

      case message.text
      when '/start'
        start(bot, message, user)
      when /^\d+$/
        save_camp_num(bot, message, user)
      when '/checkin'
        checkin(bot, message, user)
      when '/stop'
        puts user.action_status
        puts user.request_status
        puts user.presence_status
        #bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        #puts '/stop message received'

=begin
      case
      when message.photo != []
        puts "photomessage received"
        large_file_id = message.photo.last.file_id

        file = bot.api.get_file(file_id: large_file_id)
        file_path = file.dig('result', 'file_path')
        uri = "https://api.telegram.org/file/bot#{token}/#{file_path}"

        File.open('photo.jpeg', 'wb') do |file|
          file.write(open(uri).read)
        end

      when message.location 
        puts "locationmessage received"
      end
=end
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (main_else)')
    end
  end
end