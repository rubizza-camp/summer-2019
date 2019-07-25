require 'yaml'
require_relative '../helpers/session_state'

module StartCommand
  include SessionStatus

  CAMP_NUMBERS = YAML.load_file('./data/numbers.yml')['numbers'].freeze

  def start!(*)
    return if start_not_registered

    save_context :register
    respond_with :message, text: 'Введи свой номер по лагерю:'
  end

  def register(*answer)
    respond_with :message, text: register_with_validation(answer)
  end

  def register_with_validation(number = nil, *)
    number = number.first.to_i

    if REDIS.get(number) || session.key?(:number)
      "Номер #{number} уже зарегистрирован, попробуй ещё -> /start!"
    elsif CAMP_NUMBERS.include?(number)
      login(REDIS, number)
    else
      'Такого номера нет в списке, попробуй ещё -> /start!'
    end
  end

  def login(redis, number)
    session[:number] = number
    redis.set(number, payload['from']['id'])
    session[:checkin] = false
    "Спасибо, #{session[:number]}, ты зарегистрирован. Можешь принять смену -> /checkin"
  end
end
