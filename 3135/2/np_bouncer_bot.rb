require 'telegram/bot'
require 'redis'
require 'dotenv/load'

require_relative './lib/event_handler'

TOKEN = ENV['TELEGRAM_BOT_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    response = EventHandler.call(bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end
end
