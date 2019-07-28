require 'yaml'

module StartCommand
  def needs_checkin
    "#{session[:number]}, прими смену ~> /checkin"
  end

  def allready_checkouted
    respond_with :message, text: 'Ты принял смену. Сдашь тут ~> /checkout' if session[:checkin]
    !session[:checkin]
  end

  def start_not_registered
    respond_with :message, text: needs_checkin if session.key?(:number) && allready_checkouted
    session.key?(:number)
  end

  def start!(*)
    return if start_not_registered
    save_context :register
    respond_with :message, text: 'Введи свой номер по лагерю:'
  end

  def register(*answer)
    camp_numbers = load_file_numbers
    respond_with :message, text: register_with_validation(answer, camp_numbers)
  end

  def register_with_validation(number = nil, *)
    number = number.first.to_i
    if REDIS.get(number) || session.key?(:number)
      "Номер #{number} уже зарегистрирован, попробуй ещё -> /start!"
    elsif camp_numbers.include?(number)
      login(REDIS, number)
    else
      'Такого номера нет в списке, попробуй ещё -> /start!'
    end
  end

  def login(number)
    session[:number] = number
    redis.set(number, payload['from']['id'])
    session[:checkin] = false
    "Спасибо, #{session[:number]}, ты зарегистрирован. Можешь принять смену -> /checkin"
  end

  private

  def load_file_numbers
    YAML.load_file('./data/numbers.yml')['numbers'].freeze
  end
end
