# frozen_string_literal: true

require 'pry'
require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'json'

TOKEN = '935196824:AAErWgXg1n1IfOVWQFfPnTqyie5aDmZdfsk'

class GithubParser

  attr_reader :list_numbers

  def parse
    @list_numbers = []
    numbers = Nokogiri::HTML(HTTParty.get('https://github.com/rubizza-camp/summer-2019'))
    numbers = numbers.css('span.css-truncate.css-truncate-target a.js-navigation-open').each do |number| 
      number = number.text.to_i
      @list_numbers << number if number != 0
    end
  end
end

@students = GithubParser.new
@students.parse

@check_list = []
@stage = {stage: 0}
@check_data = {
                location_longitude: nil,
                location_latitude: nil,
                start_time: 0,
                end_time: 0,
                photo: nil
}

def check_number(message)
  number = message.chomp.to_i
  if @check_list.include?(number)
    @stage[:stage] = 1
    return 'You already registred! Enter command /checkin or /checkout'
  elsif @students.list_numbers.include?(number)
    @check_list << number 
    @stage[:stage] = 1
    return 'Ok, your ID registered! Next you need to /checkin'
  else
    return 'Unfortunally, this number is not in the list. Try another number.'
  end
end

def check_status(status_to_compare)
  @stage[:stage] == status_to_compare ? true : false
end

def save_photo(message)
  id_photo = message.photo
  @check_data[:photo] = id_photo
end

def save_location(message)
  longitude = message.location.longitude
  latitude = message.location.latitude
  @check_data[:location_longitude] = longitude
  @check_data[:location_latitude] = latitude
end

def working_hour(end_time)
  @check_data[:start_time] - end_time
end

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', 'start' ,'s'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey, input your number, #{message.from.first_name}")
      bot.listen do |message|
        bot.api.send_message(chat_id: message.chat.id, text: "Wait, i am searching!")
        answer = check_number(message.text)
        bot.api.send_message(chat_id: message.chat.id, text: answer)
        break if check_status(1)
      end
    when '/checkin'
      bot.listen do |message|
        break if check_status(2)
        bot.api.send_message(chat_id: message.chat.id, text: "Ok you checkin starts at #{message.date}, #{message.from.first_name}")
        bot.api.send_message(chat_id: message.chat.id, text: "Send me location")
        bot.listen do |message|
          break if check_status(2)
          save_location(message) if message.location
          bot.api.send_message(chat_id: message.chat.id, text: "Location received.") if message.location
          bot.api.send_message(chat_id: message.chat.id, text: "Then send me photo!")
          bot.listen do |message| 
            break if check_status(2)
            save_photo(message)
            bot.api.send_message(chat_id: message.chat.id, text: "Photo received") if message.photo
            @stage[:stage] = 2 if (@check_data[:location] && @check_data[:photo])
            bot.api.send_message(chat_id: message.chat.id, text: "Have a nice day! Dont forget to make /checkout")
            @check_data[:start_time] = message.date.to_i
            puts "#{@stage}"
          end
          break if check_status(2)
        end
        break if check_status(2)
        puts "You on stage #{@stage}"
        puts "#{}"
      end
      p @check_data[:start_time]
    when '/checkout'
      if @stage[:stage] = 2
      difference = working_hour(message.date.to_i)
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, today you worked #{difference}")

    end

    else
      bot.api.send_message(chat_id: message.chat.id, text: "Somthing going wrong, try to /start")  
    end
  end
end

