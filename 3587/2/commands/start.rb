module StartCommand
  def start!(*)
    return respond_with :message, text: REGISTERED if account_registered?
    respond_with :message, text: "Hi, #{from['first_name']}! Enter your number, please."
    save_context :number_from_message
  end

  def number_from_message(*numbers)
    response = Registration.call(numbers[0], payload['from']['id'])
    respond_with :message, text: response[:message]
    start! unless response[:status]
  end
end
