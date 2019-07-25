# frozen_string_literal: true

module Start
  def self.call(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    puts "state start_helper: #{state}"
    RedisHelper.set(chat_id, :wait_number) if state == :wait_start
    puts "state start_helper: #{state}"
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)])
  end
end
