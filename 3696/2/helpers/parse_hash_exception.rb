# frozen_string_literal: true

class ParseHashException < StandardError
  ERR_MSG = 'Parse error'

  def initialize(msg = ERR_MSG)
    super
  end
end
