require 'yaml'
require_relative '../model/user_class'

# class that check user
class UserHelper
  def self.registered(id)
    User[id]
  end

  def self.check_number(number)
    file = YAML.load_file('data/stud.yml')
    file['numbers'].find { |num| num == number.to_i }
  end

  def self.find_user(number)
    reg_user = []
    User.all.each do |user|
      reg_user << user if user.number == number
    end
    reg_user
  end
end
