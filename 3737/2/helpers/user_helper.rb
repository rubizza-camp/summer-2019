require 'yaml'
require_relative '../model/user_class'

# class that check user
class UserHelper
  def self.registered(id)
    User[id]
  end

  def self.check_number(enter_number)
    file = YAML.load_file('data/stud.yml')
    file['numbers'].find { |number| number == enter_number.to_i }
  end

  def self.find_user(number)
    registrated_user = []
    student_number = number
    User.all.each do |user|
      registrated_user << user if user.number == student_number
    end
    registrated_user
  end
end
