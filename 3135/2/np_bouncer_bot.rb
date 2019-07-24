require 'telegram/bot'
require 'redis'
require 'dotenv'

require_relative 'event_handler_class'

# DB class is used to acess redis
# rubocop:disable Lint/UselessAssignment
class DB
  def self.redis
    redis ||= Redis.new
  end
end
# rubocop:enable Lint/UselessAssignment

Dotenv.load
TOKEN = ENV['TELEGRAM_BOT_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    response = EventHandler.call(bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end
end
