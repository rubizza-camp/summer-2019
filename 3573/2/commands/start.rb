require 'yaml'

DATA_PATH = './data/numbers.yaml'.freeze

module Start
  def start!(*)
    respond_with :message, text: t(:enter_number)
    save_context :register_message
  end

  # rubocop:disable Metrics/LineLength
  def register_message(number, *)
    student_number = number.to_i
    return respond_with :message, text: t(:user_number_registered, user_number: user_registered?) if user_registered?

    return respond_with :message, text: t(:already_registered) if user_number_registered?(student_number)

    return register_with_student_number(student_number) if list_of_numbers.include?(student_number)

    respond_with :message, text: t(:try_again)
  end
  # rubocop:enable Metrics/LineLength

  def register_with_student_number(student_number)
    register_student(student_number)
    respond_with :message, text: t(:registration_done)
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)['numbers'].map(&:to_i)
  end
end
