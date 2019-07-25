require 'pry'

module UserStates
  def self.already_registered?(id)
    User[id]
  end

  def self.checkin?(id)
    User[id].checkin?
  end

  def self.find_user(person_number)
    person_num = person_number
    users = []
    User.all.each do |user|
      users.push(user) if user.person_number == person_num
    end
    users
  end

  def self.update_user(id, status)
    edit_status = status
    case edit_status
    when 'checkin'
      User[id].update(checkin_datetime: Time.now, checkin?: true)
    else
      User[id].update(checkout_datetime: Time.now, checkin?: false)
    end
  end

  def self.create_user(id, name, person_number)
    User.create(id: id, name: name, person_number: person_number)
  end
end
