# frozen_string_literal: true

#sets and gets data with Redis
module RedisDo
  def self.set(chat_id, state)
    Redis.current.set(chat_id, state)
  end

  def self.get(chat_id)
    answer = Redis.current.get(chat_id)
    answer = Redis.current.set(chat_id, 'wait_start') unless answer
    answer = answer.to_sym if answer
    answer
  end
end
