# frozen_string_literal: true

require 'yaml'

DATA_PATH = './data/camp_numbers.yml'
IMAGE_DOG_PATH = './modules/dogs.jpg'
NUMBERS_LIST_KEY = 'camp_numbers'
LIST_OF_COMMANDS = [
  '/start',
  '/remove_account',
  '/checkin',
  '/checkout'
].freeze

module StartCommand
  def start!(*)
    print_list_of_command
    respond_with :message, text: user_name.to_s + I18n.t(:START_RESPONSE)
    respond_with :photo, photo: File.open(IMAGE_DOG_PATH)
    save_context :message_register
  end

  def message_register(first_word, *)
    student_number = first_word.to_i
    return response_for_registered_student if user_registered?
    return response_for_busy_student_number if student_number_busy?(student_number)
    return response_for_register_student(student_number) if list_of_numbers.include?(student_number)
    respond_for_different_situation
  end

  private

  def student_number_busy?(student_number)
    redis.get(student_number)
  end

  def response_for_registered_student
    respond_with :message, text: I18n.t(:REGISTERED_RESPONSE) + redis.get(user_id_telegram).to_s
  end

  def response_for_busy_student_number
    respond_with :message, text: I18n.t(:STUDENT_NUMBER_BUSY_RESPONSE)
    start!
  end

  def response_for_register_student(student_number)
    register_student(student_number)
    respond_with :message, text: I18n.t(:SUCCESSFUL_REGISTRATION_RESPONSE)
  end

  def respond_for_different_situation
    respond_with :message, text: I18n.t(:FAILED_REGISTRATION_RESPONSE)
    start!
  end

  def print_list_of_command
    respond_with :message, text: I18n.t(:LIST_OF_COMMANDS_RESPONSE)
    LIST_OF_COMMANDS.each do |name_of_command|
      respond_with :message, text: name_of_command
    end
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)[NUMBERS_LIST_KEY]
  end

  def register_student(student_number)
    redis.set(user_id_telegram, student_number)
    redis.set(student_number, true)
  end
end
