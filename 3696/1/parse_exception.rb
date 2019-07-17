# frozen_string_literal: true

class ParseException < StandardError
  def initialize(msg = 'My default message')
    super
  end
end
