require 'telegram/bot'
require 'open-uri'

token = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      #puts message.inspect
      #puts message.methods

      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        puts '/start message received'
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        puts '/stop message received'
      end

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

    end
end