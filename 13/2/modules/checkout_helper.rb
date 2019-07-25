# frozen_string_literal: true

module CheckoutHelper 
  def self.do(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    #puts "state checkout_helper_helper: #{state}"
      if state == :wait_checkout
        RedisHelper.set(chat_id, :wait_start)
        answer = 'You logged out! Bye!'
        answer
      end
    #puts "state check_out__helper: #{state}" 
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)]) unless answer
    BotAnswers.put_message(bot, message, answer) if answer
  end
end
