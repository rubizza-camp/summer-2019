module StartCommand
  def start!(*)
    response = student_number.to_s + I18n.t(:start_register)
    return respond_with :message, text: response if account_registered?

    response = from['first_name'].to_s + I18n.t(:start_unregister)
    respond_with :message, text: response
    save_context :number_from_message
  end

  def number_from_message(*words)
    response = StudentRegistrator.call(words[0], payload['from']['id'])
    respond_with :message, text: response[:message]
    start! unless response[:status]
  end
end
