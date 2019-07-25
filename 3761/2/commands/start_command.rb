module StartCommand
  def start!(*)
    response_message = t(:start_register, student_number: student_number)
    return respond_with :message, text: response_message if account_registered?

    response_message = t(:start_unregister, first_name: payload['from']['first_name'])
    respond_with :message, text: response_message
    save_context :number_from_message
  end

  def number_from_message(*words)
    StudentRegistrator.call(words.first, payload['from']['id'])
    checkout
    respond_with :message, text: t(:start_end)
  rescue Errors::InvalidNumberError
    handle_invalid_number
  rescue Errors::StudentAlreadyExistError
    handle_student_already_exist
  end

  private

  def handle_invalid_number
    respond_with :message, text: t(:invalid_number)
    start!
  end

  def handle_student_already_exist
    respond_with :message, text: t(:student_already_exist)
    start!
  end
end
