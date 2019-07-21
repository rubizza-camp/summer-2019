require 'telegram/bot'
require 'redis'

#require 'open-uri'
#require_relative 'UserData_class'
require_relative 'User_info_class_set'
require_relative 'event_handler.rb'

redis = Redis.new
token = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    tg_id = message.from.id
    user = UserInfo.new(redis, tg_id)

    case message.text
    when '/start'
      start(bot, message, user)
    when /^\d+$/
      save_camp_num(bot, message, user)
    when '/checkin'
      checkin(bot, message, user)
    when '/checkout'
      checkout(bot, message, user)
    when '/status'
      puts user.action.what?
      puts user.request.what?
      puts user.present?

    else
      case
      when message.photo.any?
        photo(bot, message, user, token)
      when message.location 
        location(bot, message, user)
      else
        bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (main switch)')  
      end
    end
  end
end