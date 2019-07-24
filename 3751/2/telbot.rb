# rubocop:disable all
require 'telegram/bot'
require_relative 'redis_helper.rb'
require_relative 'save_helper.rb'
require_relative 'authorized_user.rb'
require_relative 'user.rb'
include RedisHelper
token = '800969602:AAFvEr0wrEkUc5ArQAoHaXSGnWmV2Yx5Xn4'

class Bot
  def run
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        answer = message_handler(message, bot)
        say(answer, bot, message)
      end
    end
  end

  def message_handler(message, bot)
    if camp_user?
      save_helper = SaveHelper.new(bot, token)
      AuthorizedUser.new(save_helper).call(message)
    else
      User.new.call(message)
    end
  end

  def say(answer, bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: "#{answer}")
  end
end
