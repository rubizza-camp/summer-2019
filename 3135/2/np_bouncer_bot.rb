require 'telegram/bot'
#require 'redis'
#require 'open-uri'
require_relative 'UserData_class'

#RedisDB0 = Redis.new(host: 'localhost')

token = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|

      case message.text
      when '/start'
        user = UserData.new(message.from.id)
        if user.resident?
          bot.api.send_message(chat_id: message.chat.id, text: "you're already registered")
        else
          user.assign_action_status('register')
          user.assign_request_status('camp_num')
          bot.api.send_message(chat_id: message.chat.id, text: 'provide camp num')
        end
      when '/stop'
        user = UserData.new(message.from.id)
        puts user.action_status
        puts user.request_status


        #bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        #puts '/stop message received'
      end

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

    end
end