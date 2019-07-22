require 'telegram/bot'
require 'yaml'
require_relative 'number_checker'

module StartContext
include NumberChecker

    #def start(*)
     # save_context :start_message
      #respond_with :message, text: 'Hello, rook! Enter your camp number'
    #end

    def start!(message = nil, *)
    if message
      save_context :start!
      resp = ''
      number =  message
      resp = handle_number('Data/camp_participants.yaml', number)
      resp = "I'm sorry, but there isn't anyone in the camp with #{number} number" if resp == ''
      respond_with :message, text: "#{resp}"
    else
      save_context :start!
      respond_with :message, text: 'Hello, rook! Enter your camp number'
    end
  end

    #def start_message(*message)
     # resp = ''
     # puts message.inspect
     # number =  message[0]['text']
      #resp = handle_number('Data/camp_participants.yaml', number)
      #resp = "I'm sorry, but there isn't anyone in the camp with #{number} number" if resp == ''
      #respond_with :message, text: "#{resp}"
    #end
end
