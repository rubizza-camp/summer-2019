# frozen_string_literal: true

module Checkout
  def self.call(bot, message)
    chat_id = message.chat.id
    state = RedisHelper.get(chat_id)
    RedisHelper.set(chat_id, :wait_checkout_location) if state == :wait_checkout
    BotAnswers.put_message(bot, message, BotAnswers::RESPONSES[RedisHelper.get(chat_id)])
  end
end
