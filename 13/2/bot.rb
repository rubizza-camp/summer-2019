# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'fileutils'
require 'geocoder'
require 'down'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'modules/github_parser'
require_relative 'modules/redis_do'
require_relative 'modules/location'
require_relative 'modules/photo'

Redis.new.flushall

TOKEN = '935196824:AAFALTOy8UMgbOXpIp9SewpWTHSNlHakBOg'

STUDENTS = GithubParser.new.parse

STATE = {
  wait_start:             'Hey, you currently not logged in, push /start',
  wait_number:            'Lets enter your correct RUBIZZA number',
  wait_checkin:           'Your number is ok, push /checkin',
  wait_location:          'You checked in, need location',
  wait_photo:             'Your location received, wait for your photo',
  wait_checkout:          'Your photo and location received, you may /checkout',
  wait_checkout_location: 'You pushed checkout, let me see you location',
  wait_checkout_photo:    'Then, for checkout we need your photo'}

  class Else
    def self.call(bot, message, chat_id, state)
      case state
      when :wait_number            then Else.number(chat_id, message)
      when :wait_location          then Else.location(chat_id, message, 'checkins', :wait_photo )
      when :wait_photo             then Else.photo(bot, chat_id, message, 'checkins', :wait_checkout )
      when :wait_checkout_location then Else.location(chat_id, message, 'checkouts', :wait_checkout_photo )
      when :wait_checkout_photo    then Else.photo(bot, chat_id, message, 'checkouts', :wait_start )
      end
    end

    def self.number(chat_id, message)
      student = message.text.to_i
      if STUDENTS.include?(student)
        RedisDo.set("chat:#{chat_id}:student", student)
        RedisDo.set(chat_id, :wait_checkin)
      end
    end

    def self.photo(bot, chat_id, message, folder, suc_state)
      unless message.photo.empty?
        student = RedisDo.get("chat:#{chat_id}:student")
        timestamp = RedisDo.get("chat:#{chat_id}:timestamp")
        photo_id = message.photo.last.file_id
        if message.photo.size > 1
          if Photo.save(bot, photo_id, student, timestamp, folder)
            RedisDo.set(chat_id, suc_state)
          end
        end
      end
    end

    def self.location(chat_id, message, folder, suc_state)
      student = RedisDo.get("chat:#{chat_id}:student")
      if Location.save(chat_id, student, message, folder)
        RedisDo.set(chat_id, suc_state) 
      end
    end
  end

  Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
      chat_id = message.chat.id
      state = RedisDo.get(chat_id)
      case message.text
      when '/start'    then Start.call(chat_id, state)
      when '/checkin'  then Checkin.call(chat_id, state)
      when '/checkout' then Checkout.call(chat_id, state)
      else                  Else.call(bot, message, chat_id, state)
      end
      bot.api.send_message(chat_id: chat_id, text: STATE[RedisDo.get(chat_id)])
    end
  end

