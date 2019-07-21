module StartCommand
  def start!(*)
    response = "#{student_number}, You\'ve already registered! You can continue."
    return respond_with :message, text: response if account_registered?

    response = "Hi, #{from['first_name']}! Enter your number, please."
    respond_with :message, text: response
    save_context :number_from_message
  end

  def number_from_message(*words)
    response = StudentRegistrator.call(words[0], payload['from']['id'])
    respond_with :message, text: response[:message]
    start! unless response[:status]
  end
end
