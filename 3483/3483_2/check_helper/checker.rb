require 'yaml'
require_relative '../registration/guest'

class Checker
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def correct_data?
    check_number && not_find_user
  end

  def self.registered(id)
    Guest[id]
  end

  def find_user
    Guest.all.any? { |guest| guest.number.include?(number) }
  end

  def not_find_user
    !find_user
  end

  def check_number
    @check_number ||= YAML.load_file('humans.yaml')['Humans'].include?(number)
  end
end


