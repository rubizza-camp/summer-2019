# frozen_string_literal: true

require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'down'
require 'fileutils'
require 'geocoder'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'modules/studentsparser'
require_relative 'modules/redis_helper'
require_relative 'modules/bot_answers'
require_relative 'modules/location'
require_relative 'modules/photo'
require_relative 'modules/folder'

TOKEN = '935196824:AAFALTOy8UMgbOXpIp9SewpWTHSNlHakBOg'

class User
  STUDENTS = StudentsParser.new.parse

  def start_session
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
        when '/start' then Start.call(bot, message)
        when '/checkin' then Checkin.call(bot, message)
        when '/checkout' then Checkout.call(bot, message)
        else
          chat_id = message.chat.id
          state = RedisHelper.get(chat_id)
          if (state == :wait_number) || (state == :number_incorrect)
            student = message.text.to_i
            if STUDENTS.include?(student)
              timestamp = Time.now
              RedisHelper.set("chat:#{chat_id}:student", student)
              RedisHelper.set("chat:#{chat_id}:timestamp", timestamp)
              RedisHelper.set(chat_id, :wait_checkin)
            else
              RedisHelper.set(chat_id, :number_incorrect)
            end
          end
          student = RedisHelper.get("chat:#{chat_id}:student")
          timestamp = RedisHelper.get("chat:#{chat_id}:timestamp")
          if state == :wait_location
            RedisHelper.set(chat_id, :wait_photo) if Location.save(student, message, 'checkins')
          end
          if state == :wait_photo
            unless message.photo.empty?
              photo_id = message.photo.last.file_id
              if message.photo.size > 1
                RedisHelper.set(chat_id, :wait_checkout) if Photo.save(bot, photo_id, student, timestamp, 'checkins')
              end
            end
          end
          if state == :wait_checkout_location
            student = RedisHelper.get("chat:#{chat_id}:student")
            if Location.save(student, message, 'checkouts')
              RedisHelper.set(chat_id, :wait_checkout_photo) 
            end
          end
          if state == :wait_checkout_photo
            unless message.photo.empty?
              student = RedisHelper.get("chat:#{chat_id}:student")
              timestamp = RedisHelper.get("chat:#{chat_id}:timestamp")
              photo_id = message.photo.last.file_id
              if message.photo.size > 1
                if Photo.save(bot, photo_id, student, timestamp, 'checkouts')
                  RedisHelper.set(chat_id, :wait_start) 
                  answer = 'You logged out! Bye!'
                end
                answer
              end
            end
          end
          BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)]) unless answer
          BotAnswers.put_message(bot, message, answer) if answer
        end
      end
    end

  end
end

user = User.new.start_session
