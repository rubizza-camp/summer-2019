require './models/user.rb'
module StartCommand
  def start!(person_id = nil, *)
    numbers = File.open('data/users.yml', 'r').read.split(' ')
    if person_id
      check_number_is_used(person_id, numbers)
    else
      respond_with :message, text: 'Солнышко, введи свой номер'
      save_context :start!
    end
  end

  def check_number_is_used(person_id, numbers)
    if !check_number(person_id).empty?
      respond_with :message, text: "Это номер уже использует #{check_number(person_id).first.name}"
    elsif user_id
      respond_with :message, text: "Ты уже зарегестрирован как #{user_id.personal_id}"
    else
      check_number_from_list(person_id, numbers)
    end
  end

  def user_id
    User[from['id']]
  end

  def check_number_from_list(person_id, numbers)
    if numbers.include?(person_id)
      create_user(person_id)
    else
      respond_with :message, text: "Не не не, #{person_id} у нас нет"
    end
  end

  def create_user(person_id)
    User.create(id: from['id'], name: from['last_name'], personal_id: person_id, checkin: 'false')
    respond_with :message, text: 'Молодец, я доволен'
  end

  def check_number(person_id)
    User.all.select { |user| user.personal_id == person_id }
  end
end
