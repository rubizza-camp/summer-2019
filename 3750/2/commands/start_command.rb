module StartCommand
  def start!(*)
    respond_with :message, text: 'Hello!'
    save_context :number_check
    respond_with :message, text: 'Tell me your Number'
  end

  def number_check(number = nil, *)
    if session.values.include?(number)
      respond_with :message, text: "Greetings #{number}!"
    else
      respond_with :message, text: "I don't know you #{number}!"
      respond_with :message, text: 'Maybe your number just not registered yet'
      respond_with :message, text: 'Let me check you in list'
      if read_file_into_arr.include? number
        session[from['id']] = number
        respond_with :message, text: 'Yep, you just new to this place'
      else
        respond_with :message, text: 'Nope, there is no such number'
        respond_with :message, text: "Shame, i can't let you in"
      end
    end
  end
end