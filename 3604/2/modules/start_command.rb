# frozen_string_literal: true

require 'yaml'

module StartCommand
  DATA_PATH = './data/camp_numbers.yml'
  IMAGE_DOG_PATH = './modules/dogs.jpg'
  NUMBERS_LIST_KEY = 'camp_numbers'

  def start!(*)
    respond_with :message, text: user_name.to_s + I18n.t(:start_response)
    respond_with :photo, photo: File.open(IMAGE_DOG_PATH)
    save_context :message_register
  end

  def message_register(number, *)
    return response_for_registered_student if user_registered?
    return response_for_busy_student_number if student_number_reserved?(number.to_i)
    return response_for_register_student(number.to_i) if list_of_numbers.include?(number.to_i)
    respond_for_different_situation
  rescue NoMethodError
    respond_with :message, text: I18n.t(:empty_list_of_numbers_response)
  end

  private

  def student_number_reserved?(student_number)
    redis.get(student_number)
  end

  def response_for_registered_student
    respond_with :message, text: I18n.t(:registered_response) + redis.get(user_id_telegram).to_s
  end

  def response_for_busy_student_number
    respond_with :message, text: I18n.t(:student_number_reserved_response)
    start!
  end

  def response_for_register_student(student_number)
    register_student(student_number)
    respond_with :message, text: I18n.t(:successful_registration_response)
  end

  def respond_for_different_situation
    respond_with :message, text: I18n.t(:failed_registration_response)
    start!
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)[NUMBERS_LIST_KEY]
  end

  def register_student(student_number)
    redis.set(user_id_telegram, student_number)
    redis.set(student_number, true)
  end
end
