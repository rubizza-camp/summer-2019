module StartCommand
  def start!(*)
    response = I18n.t(:start_register, student_number: student_number)
    return respond_with :message, text: response if account_registered?

    response = I18n.t(:start_unregister, first_name: payload['from']['first_name'])
    respond_with :message, text: response
    save_context :number_from_message
  end

  def number_from_message(*words)
    StudentRegistrator.call(words.first, payload['from']['id'])
    respond_with :message, text: I18n.t(:start_end)
  rescue Errors::InvalidNumberError
    handle_invalid_number
  rescue Errors::StudentExistError
    handle_student_already_exist
  end

  private

  def handle_invalid_number
    respond_wrong_number
    start!
  end

  def handle_student_already_exist
    respond_student_exist
    start!
  end
end
