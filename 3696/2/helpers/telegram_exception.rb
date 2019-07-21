# frozen_string_literal: true

class TelegramException < StandardError
  ERR_MSG = 'Servers\' error'
  def initialize(msg = ERR_MSG)
    super
  end
end
