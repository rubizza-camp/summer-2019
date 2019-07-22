module StartCommand
  def start!
    if registered?
      respond_with :message, text: "You're already registerd!"
    else
      save_context :input_camp_number
      respond_with :message, text: 'Hello! Give me your number, please'
    end
  end

  def input_camp_number(number)
    session[session_key] ||= {}
    session[session_key]['number'] ||= number
    respond_with :message, text: 'Registration is successful. Thank you'
  end

  def registered?
    session[session_key]
  end
end
