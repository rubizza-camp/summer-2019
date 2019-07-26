require 'yaml'

DATA_PATH = './data/numbers.yaml'.freeze

module Start
  def start!(*)
    respond_with :message, text: t(:enter_number)
    save_context :register_message
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/LineLength
  def register_message(number, *)
    student_number = number[0].to_i
    return respond_with :message, text: t(:user_number_registered) + user_registered?.to_s if user_registered?

    return respond_with :message, text: t(:already_registered) if user_number_registered?

    return response_register_student(student_number) if list_of_numbers.include?(student_number)

    respond_with :message, text: t(:try_again)
  end
  # rubucop:enable Metrics/LineLength
  # rubocop:enable Metrics/AbcSize, Metrics/LineLength

  def response_register_student(student_number)
    register_student(student_number)
    respond_with :message, text: t(:registration_done)
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)['numbers'].map(&:to_i)
  end
end
