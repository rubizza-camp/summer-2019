require 'telegram/bot'
require 'yaml'
require './Lib/Utiles/number_checker.rb'

module StartContext
  def start!(message = nil, *)
    save_context :start!
    if message
      answer = response(message)
      respond_with :message, text: answer
    else
      respond_with :message, text: 'Hello, rook! Enter your camp number'
    end
  end

  private

  def response(message)
    number_checker = NumberChecker.new('Data/camp_participants.yaml')
    number_checker.handle_number(message, payload)
  end
end
