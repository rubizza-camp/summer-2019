require_relative '../../models/user.rb'

module StartCommand
  def start!(person_number = nil, *)
    redis = Redis.new(host: "127.0.0.1")
    numbers = File.open('data/numbers'){|file| file.read}.split("\n")
    if person_number.to_i != 0
      User.all.each do |user|
        if user.person_number == person_number
          respond_with :message, text: "Наебать решил, этот номер принадлежит #{user.name}"
          save_context :start!
          return 0
        end
      end
      if User[from['id']]
        respond_with :message, text: "Ты уже зарегистрирован как #{User[from['id']].person_number}"
      elsif numbers.include?(person_number)
        User.create(id: from['id'], name: from['first_name'], person_number: person_number)
        respond_with :message, text: 'Зарегистрирован'
      end
    else
      save_context :start!
      respond_with :message, text: 'Введи-ка свой номерок!!'
    end
  end
end
