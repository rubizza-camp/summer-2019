require_relative '../helpers/event_handler'

module CheckInCommand
  include EventHandler

  def checkin!
    if chat_session[session_key]['status'] == 'in'
      respond_with :message, text: "You're already in. Please, make /checkout command"
    else
      chat_session[session_key]['message'] = 'Goodluck! And be bold today!'
      event
    end
  end
end
