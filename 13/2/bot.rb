# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'down'
require 'fileutils'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'modules/studentsparser'
require_relative 'modules/else_controller'
require_relative 'modules/redis_helper'
require_relative 'modules/bot_answers'
require_relative 'modules/location'
require_relative 'modules/photo'
require_relative 'modules/folder'

#test mode Redis.new.flushall
Redis.new.flushall

TOKEN = '935196824:AAFALTOy8UMgbOXpIp9SewpWTHSNlHakBOg'

STUDENTS = StudentsParser.new.parse

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start' then Start.call(bot, message)#start_helper(message, bot)
    when '/checkin' then Checkin.call(bot, message)#checkin_helper(message, bot)
    when '/checkout' then Checkout.call(bot, message)#checkout_helper(message, bot)
    else ElseController.call(bot, message) #else_helper(message, bot)
    end
  end
end
