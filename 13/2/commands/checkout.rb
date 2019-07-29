# frozen_string_literal: true

module Checkout
  def self.call(chat_id, state)
    RedisDo.set(chat_id, :wait_checkout_location) if state == :wait_checkout
  end
end
