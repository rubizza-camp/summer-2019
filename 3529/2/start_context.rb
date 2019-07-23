require 'telegram/bot'
require 'yaml'
require_relative 'number_checker'

module StartContext
  def start!(message = nil, *)
    save_context :start!
    if message
      answer = response(message)
      respond_with :message, text: answer.to_s
    else
      respond_with :message, text: 'Hello, rook! Enter your camp number'
    end
  end

  private

  def response(message)
    number_checker = NumberChecker.new('Data/camp_participants.yaml')
    result = number_checker.handle_number(message, payload)
    if result == ''
      "I'm sorry, but there isn't anyone in the camp with #{message} number"
    else
      result
    end
  end
end
