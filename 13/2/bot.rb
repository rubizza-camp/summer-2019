# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'fileutils'
require 'geocoder'
require 'down'
require 'dotenv/load'

Dir['commands/*.rb'].each { |f| require_relative f }
Dir['lib/*.rb'].each { |f| require_relative f }

#for test mode
Redis.new.flushall

BOT_MESSAGES = {
 wait_start:             'Hey, you currently not logged in, push /start',
 wait_number:            'Lets enter your correct RUBIZZA number',
 wait_checkin:           'Your number is ok, push /checkin',
 wait_location:          'You checked in, let me see your location',
 wait_photo:             'Your location received, wait for your photo',
 wait_checkout:          'Your photo and location received, you may /checkout',
 wait_checkout_location: 'You pushed checkout, let me see you location',
 wait_checkout_photo:    'Then, for checkout we need your photo'
}

Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    user = User.new(message.chat.id)
    puts "1"
    puts "STATE #{user.state}"
    case message.text
    when '/start'    then StartCommand.new(user).call
    when '/checkin'  then CheckinCommand.new(user).call
    when '/checkout' then CheckoutCommand.new(user).call
    else
      case user.state.to_sym
      when :wait_number
        SetNumberCommand.new(user).call(message.text.to_i, 
        StudentsParser.students_list)
      when :wait_location, :wait_checkout_location
        puts "2"
        SetLocationCommand.new(user).call(message.location)
      when :wait_photo, :wait_checkout_photo
        SetPhotoCommand.new(user, bot.api).call(message.photo)
      end
    end
    puts "3"
    bot.api.send_message(
      chat_id: user.chat_id,
      text: BOT_MESSAGES[user.state.to_sym]
    )
    puts '4'
   end
end
