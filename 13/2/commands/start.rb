# frozen_string_literal: true

module Start
  def self.call(chat_id, state)
    RedisDo.set(chat_id, :wait_number) if state == :wait_start
  end
end
