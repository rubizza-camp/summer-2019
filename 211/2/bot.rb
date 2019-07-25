require 'dotenv/load'
require 'redis'
require 'telegram/bot'

require_relative 'lib/event_handler.rb'

Telegram::Bot::Client.run(Settings.token) do |bot|
  bot.listen do |message|
    response = EventHandler.resolve(message, bot)
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end
end
