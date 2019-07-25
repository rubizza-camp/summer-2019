require 'yaml'

DATA_PATH = './data/numbers.yaml'.freeze

module Start
  def start!(*)
    respond_with :message, text: t(:enter_number)
    save_context :register_message
  end

  def register_message(number, *)
    student_number = number[0].to_i
    return response_if_have_id_telegram? if user_registered?

    return response_if_have_number? if user_number_registered?

    return response_if_number_in_list?(student_number) if list_of_numbers.include?(student_number)

    response_if_error
  end

  def response_if_have_id_telegram?
    respond_with :message, text: t(:user_id_telegram) + user_registered?.to_s
  end

  def response_if_have_number?
    respond_with :message, text: t(:already_registered)
  end

  def response_if_number_in_list?(student_number)
    register_student(student_number)
    respond_with :message, text: t(:registration_done)
  end

  def response_if_error
    respond_with :message, text: t(:try_again)
    start!
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)['numbers'].map(&:to_i)
  end
end
