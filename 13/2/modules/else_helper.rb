# frozen_string_literal: true

module ElseHelper 
  def self.do(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    #puts "state top else_helper: #{state}"
    if (state == :wait_number) || (state == :number_incorrect)
      student = message.text.to_i
      if STUDENTS.include?(student)
        RedisHelper.set(chat_id, :wait_checkin)
        Folder.create(student.to_s, "/public/#{student}")
      else
        RedisHelper.set(chat_id, :number_incorrect)
      end
    end
    #puts "7) state bottom else_helper: #{state}"
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)])
  end
end
