# frozen_string_literal: true

require 'pry'
require 'telegram/bot'
require 'redis'
require 'httparty'
require 'nokogiri'
require 'time'
require 'json'
require 'down'
require 'fileutils'
require_relative 'modules/githubparser'

TOKEN = 'censored'

#test mode Redis.new.flushall
Redis.new.flushall

def redis_set(chat_id, stage)
  Redis.current.set(chat_id.to_i, stage.to_i)
end

def redis_get(chat_id)
  Redis.current.get(chat_id).to_i  
end

def students(input)
  students = GithubParser.new
  list_numbers = students.parse
  list_numbers.include?(input)
end

def current_stage(stage)
  answer = stage
  case answer
  when 0 then return 'Hey, push /start'
  when 1 then return 'You pushed start, lets enter your number'
  when 2 then return 'This incorrect, enter correct number' 
  when 3 then return 'Your number is ok, push /checkin'  
  when 4 then return 'You checked in, need location'
  when 5 then return 'Your location received, wait for your photo'
  when 6 then return 'Your photo and location received, you may /checkout'
  end
end

def put_message(bot, message, answer)
  bot.api.send_message(chat_id: message.chat.id, text: "#{answer}")
end

def create_folder(dirname, path)
  dirname = File.dirname(path)
  unless File.directory?(dirname)
  FileUtils.mkdir_p(dirname)
  end
end

def write_in_file(name_file, content)
  file = File.open("#{name_file}", "w")
  file.write("#{content}")
  file.close
end

def location(message)
  latitude, longitude = message.location.latitude, message.location.longitude
  write_in_file("#{timestamp}/geo.txt", "Location: latitude: #{latitude}, longitude: #{longitude}")
end

#def photo(message, url, destination)
#  Down.download("#{url}", destination: "#{destination}", max_size: 1 * 300 * 300)
#end

def start_helper(message, bot)
  chat_id = message.chat.id.to_i
  stage = redis_get(chat_id)
  redis_set(chat_id, 1) if stage <= 1
  puts "stage start_helper: #{stage}"
  answer = current_stage(redis_get(chat_id))
  return put_message(bot, message, answer)
end

def checkin_helper(message, bot)
  chat_id = message.chat.id.to_i
  stage = redis_get(chat_id)
  redis_set(chat_id, 4) if (3..4).include?(stage)
  answer = current_stage(redis_get(chat_id))
  puts "stage in checkin_helper: #{stage}"
  return put_message(bot, message, answer)
end

def checkout_helper(message, bot)
  chat_id = message.chat.id.to_i
  stage = redis_get(chat_id)
  if stage == 6
    redis_set(chat_id, 0) 
    answer = 'You logged out! Bye!'
    answer
  end
   puts "stage in stage_helper: #{stage}"
  return put_message(bot, message, answer)
end

def else_helper(message, bot)
  chat_id = message.chat.id.to_i
  stage = redis_get(chat_id)
  if (1..2).include?(stage)
    input = message.text.to_i
    puts "Input text: #{input}"
    if students(input)
    redis_set(chat_id, 3)
    else
    redis_set(chat_id, 2)
    end
  end
  if stage == 4 then redis_set(chat_id, 5) end
  if stage == 5 then redis_set(chat_id, 6) end
  #if stage == 4 then location(message) end
  #if stage == 5 then photo(message) end
  answer = current_stage(redis_get(chat_id))
   puts "stage in else_helper: #{stage}"
  return put_message(bot, message, answer)
end

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start' then start_helper(message, bot)
    when '/checkin' then checkin_helper(message, bot)
    when '/checkout' then checkout_helper(message, bot)
    else else_helper(message, bot)
    end
  end
end
