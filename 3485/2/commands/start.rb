# frozen_string_literal: true

require 'yaml'

DATA_PATH = './data/numbers.yml'
NUMBERS = 'numbers'
COMMANDS = [
  '/start',
  '/checkin',
  '/checkout',
  '/test'
].freeze

# registration and list commands
module Start
  def start!(*)
    print_list_of_command
    respond = "#{from['first_name']}! Введите ваш номер."
    respond_with :message, text: respond
    save_context :message_register
  end

  def test!(*)
    respond_with :photo, photo: File.open('qjeip_u_4rU.jpg')
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
    respond = "Вы зарегались. #{redis.get(user_id_telegram)}"
    respond_with :message, text: respond
  end

  def respond_if_redis_have_number
    respond = 'Такой номер уже зареган.'
    respond_with :message, text: respond
    start!
  end

  def respond_if_number_exists(number)
    registration(number)
    respond = 'Вы уже зарегались.'
    respond_with :message, text: respond
  end

  def respond_if_different_situation
    respond = 'чё ты ввёл бл?'
    respond_with :message, text: respond
    start!
  end

  def print_list_of_command
    respond_with :message, text: 'Cписок доступных команд'
    COMMANDS.each do |name_of_command|
      respond_with :message, text: name_of_command
    end
  end

  def camp_numbers
    @camp_numbers ||= YAML.load_file(DATA_PATH)[NUMBERS]
  end

  def registration(number)
    redis.set(user_id_telegram, number)
    redis.set(number, true)
  end
end
