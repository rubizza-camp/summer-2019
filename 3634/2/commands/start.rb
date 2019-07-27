module StartCommand
  def start!
    if registered?
      respond_with :message, text: "You're already registerd! Please, make /checkin or \/checkout"
    else
      save_context :input_camp_number
      chat_session[session_key] ||= {}
      respond_with :message, text: 'Hello! Give me your number, please'
    end
  end

  def input_camp_number(number)
    if number_valid?(number)
      chat_session[session_key]['number'] ||= number
      respond_with :message, text: 'Registration is successful. You may do \/checkin command'
    else
      save_context :input_camp_number
      respond_with :message, text: "This number already taken or doesn't exist! Please, try again"
    end
  end

  def number_valid?(number)
    chat_session.values.any? { |user| number != user['number'] } &&
      Psych.load_file('data.yml')['students'].any? { |file_number| file_number.to_s == number }
  end

  def registered?
    chat_session[session_key]
  end
end
