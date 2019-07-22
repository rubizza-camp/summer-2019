require 'telegram/bot'
require 'redis'

#require 'open-uri'
require_relative 'user_info_class_set'
require_relative 'event_handler_class'
require_relative 'event_processing_modules'
require_relative 'utils_module'


R = Redis.new
TOKEN = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q' # should be env variable

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|

    response = EventHandler.call(bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: response)

  end
end