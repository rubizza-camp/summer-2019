require './models/user.rb'
module StartCommand
  def start!(person_id = nil, *)
    numbers = File.open('data/users.yml'){ |file| file.read }.split(' ')
    if person_id
      if !check_number(person_id).empty?
        respond_with :message, text: "Это номер уже использует #{check_number(person_id).first.name}"
      elsif User[from['id']]
        respond_with :message, text: "Ты уже зарегестрирован как #{User[from['id']].personal_id}"
      elsif numbers.include?(person_id)
        User.create(id: from['id'], name: from['last_name'], personal_id: person_id, checkin: 'false')
        respond_with :message, text: 'Молодец, я доволен'
      else
        respond_with :message, text: "Не не не, #{person_id} у нас нет"
      end
    else
      save_context :start!
      respond_with :message, text: 'Солнышко, введи свой номер'
    end
  end

  def check_number(person_id)
    User.all.select { |user| user.personal_id == person_id }
  end
end
