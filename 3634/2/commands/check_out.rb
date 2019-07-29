require_relative '../helpers/event_handler'

module CheckOutCommand
  include EventHandler

  def checkout!
    if chat_session[session_key]['status'] == 'out'
      respond_with :message, text: "You're already out. Please, make /checkin command"
    else
      chat_session[session_key]['message'] = 'Bye-bye! And see you soon!'
      event
    end
  end
end
