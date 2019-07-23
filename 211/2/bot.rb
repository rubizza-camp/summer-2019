require 'telegram/bot'
require './lib/router'
require 'redis'
require_relative './lib/user.rb'

TOKEN = ENV['IRIS_BOT']
REDIS = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    response = Router.resolve(message, bot)
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end
end
