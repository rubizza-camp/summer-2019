require 'yaml'

DATA_PATH = './data/numbers.yaml'.freeze

module Start
  def start!(*)
    respond_with :message, text: t(:enter_number)
    save_context :register_message
  end

  def register_message(number, *)
    student_number = number[0].to_i
    return response_if_have_id_telegram? if redis.get(user_id_telegram)
    return response_if_have_number? if redis.get(student_number)
    return response_if_number_in_the_list?(student_number) if list_numbers.include?(student_number)
    response_in_other_situations
  end

  def response_if_have_id_telegram?
    respond_with :message, text: t(:already_registered)
    respond_with :message, text: "Your number is #{redis.get(user_id_telegram)}."
  end

  def response_if_have_number?
    respond_with :message, text: t(:already_registered)
  end

  def response_if_number_in_the_list?(student_number)
    registration(student_number)
    respond_with :message, text: t(:registration_done)
  end

  def response_in_other_situations
    respond_with :message, text: t(:try_again)
    start!
  end

  def list_numbers
    @list_numbers ||= YAML.load_file(DATA_PATH)['numbers'].map(&:to_i)
  end

  def registration(student_number)
    redis.set(user_id_telegram, student_number)
    redis.set(student_number, true)
  end
end
