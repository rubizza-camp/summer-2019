# frozen_string_literal: true

module ElseController 
  def self.call(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    puts "state top else_helper: #{state}"
    if (state == :wait_number) || (state == :number_incorrect)
      student = message.text.to_i
      if STUDENTS.include?(student)
        puts "___OK____"
        timestamp = Time.now
        RedisHelper.set("chat:#{chat_id}:student", student)
        RedisHelper.set("chat:#{chat_id}:timestamp", timestamp)
        #
        puts RedisHelper.get("chat:#{chat_id}:timestamp")
        puts RedisHelper.get("chat:#{chat_id}:timestamp")
        #
        FileUtils.mkdir_p("public/#{student}/checkins/#{timestamp}")
        RedisHelper.set(chat_id, :wait_checkin)
        puts "___OK____"
      else
        RedisHelper.set(chat_id, :number_incorrect)
      end
    end
    puts "___OK____"
    if state == :wait_location
      student = 
      timestamp = 
      RedisHelper.set(chat_id, :wait_photo) if Location.save("public/#{student}/checkins/#{timestamp}", message)
    end
    puts "state bottom else_helper: #{state}"
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)])
  end
end
