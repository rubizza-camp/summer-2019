# frozen_string_literal: true

module Checkin 
  def self.call(chat_id, state)
    RedisDo.set(chat_id, :wait_location) if state == :wait_checkin
  end
end
