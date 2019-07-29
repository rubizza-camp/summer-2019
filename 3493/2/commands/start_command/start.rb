require_relative '../../models/user.rb'
require_relative '../../lib/user_methods'
require_relative '../../lib/number_methods'

module StartCommand
  def start!(*)
    if UserMethods.registered?(from['id'])
      respond_with :message, text: 'Ты уже зарегистрирован!'
    else
      respond_with :message, text: 'Введи номер!'
      save_context :enter_number
    end
  end

  def enter_number(person_number = nil, *)
    if UserMethods.find_users_by_person_number(person_number).empty? &&
       NumberMethods.valid_number?(person_number)
      UserMethods.create_user(from['id'], from['firts_name'], person_number)
      respond_with :message, text: 'Зарегистрирован!'
    else
      respond_with :message, text: 'Неверный номер. Такой номер либо используется,
                                      либо уже занят.'
      save_context :start!
    end
  end
end
