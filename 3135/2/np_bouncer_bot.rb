require 'telegram/bot'
require 'redis'

#require 'open-uri'
require_relative 'EventHandler_class'
require_relative 'UserInfo_class'
require_relative 'Status_class_set'
require_relative 'DataSaver_class'


R = Redis.new
TOKEN = '984354340:AAH8gSW85nD8cNX8JXPA5osPrbHYfZWdv6Q' # should be env variable

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|

    event = EventHandler.new(bot, message) 

    case message.text
    when '/start'
      event.start
    when /^\d+$/
      event.camp_num
    when '/checkin'
      event.checkin
    when '/checkout'
      event.checkout
    when '/status'
      event.status
    else
      case
      when message.photo.any?
        event.photo
      when message.location 
        event.location
      else
        event.send_negative('main switch')  
      end
    end
  end
end