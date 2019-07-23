class UserMethods
  def self.registered?(id)
    User[id]
  end

  def self.checkin?(id)
    User[id].is_checkin
  end

  def self.find_users_by_person_number(person_number)
    person_num = person_number
    users = []
    User.all.each do |user|
      users.push(user) if user.person_number == person_num
    end
    users
  end

  def self.update_user_date(id, status)
    second_status = status
    case second_status
    when 'checkins'
      User[id].update(checkin_datetime: Time.now, is_checkin: true)
    else
      User[id].update(checkout_datetime: Time.now, is_checkin: false)
    end
  end

  def self.create_user(id, name, person_number)
    User.create(id: id, name: name, person_number: person_number)
  end
end
