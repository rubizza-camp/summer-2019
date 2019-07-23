require 'telegram/bot'
require 'redis'
require 'pry'
require_relative 'dialog'

token = ''
db = Redis.new

class RubizzaWatchman
  def initialize
    # to do create storage, token enter
  end

  def run(token, db)
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        Dialog.new(message: message, bot: bot, database: db, chat_id: message.chat.id).validate
      end
    end
  end
end

RubizzaWatchman.new.run(token, db)
