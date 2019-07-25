# frozen_string_literal: true

module Checkin 
  def self.call(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    puts "state top checkin_helper: #{state}"
    RedisHelper.set(chat_id, :wait_location) if state == :wait_checkin
    puts "state bottom checkin_helper: #{state}"
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)])
  end
end
