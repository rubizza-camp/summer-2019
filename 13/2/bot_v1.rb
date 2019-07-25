# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'down'
require 'fileutils'
require_relative 'modules/studentsparser'
require_relative 'modules/start_helper'
require_relative 'modules/checkin_helper'
require_relative 'modules/checkout_helper'
require_relative 'modules/else_helper'
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
    when '/start' then StartHelper.do(bot, message)#start_helper(message, bot)
    when '/checkin' then CheckInHelper.do(bot, message)#checkin_helper(message, bot)
    when '/checkout' then CheckOutHelper.do(bot, message)#checkout_helper(message, bot)
    else ElseHelper.do(bot, message) #else_helper(message, bot)
    end
  end
end
