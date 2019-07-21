# frozen_string_literal: true

require 'pry'
require 'yaml'

DATA_PATH = './data/camp_numbers.yml'
NUMBERS_LIST_KEY = 'camp_numbers'
LIST_OF_COMMANDS = [
  '/start',
  '/delete',
  '/checkin',
  '/checkout'
].freeze

module StartCommand
  def start!(*)
    print_list_of_command
    respond = "#{from['first_name']}! Enter your camp number for registration."
    respond_with :message, text: respond
    respond_with :photo, photo: File.open('./modules/dogs.jpg')
    save_context :message_register
  end

  def message_register(*message)
    number = message[0].to_i
    return respond_if_redis_have_id if redis.get(user_id_telegram)
    return respond_if_redis_have_number if redis.get(number)
    return respond_if_number_exists(number) if list_of_numbers.include?(number)
    respond_if_different_situation
  end

  private

  def respond_if_redis_have_id
    respond = "Уou have already registered. Your number is #{redis.get(user_id_telegram)}"
    respond_with :message, text: respond
  end

  def respond_if_redis_have_number
    respond = 'This number is registered already'
    respond_with :message, text: respond
    start!
  end

  def respond_if_number_exists(number)
    registration(number)
    respond = 'Registration completed successfully :)'
    respond_with :message, text: respond
  end

  def respond_if_different_situation
    respond = "I'm sorry, I don't see your number in list camp:("
    respond_with :message, text: respond
    start!
  end

  def print_list_of_command
    respond_with :message, text: 'List of commands:'
    LIST_OF_COMMANDS.each do |name_of_command|
      respond_with :message, text: name_of_command
    end
  end

  def list_of_numbers
    @list_of_numbers ||= YAML.load_file(DATA_PATH)[NUMBERS_LIST_KEY]
  end

  def registration(number)
    redis.set(user_id_telegram, number)
    redis.set(number, true)
  end
end
