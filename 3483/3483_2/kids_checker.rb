require 'yaml'
require_relative 'gest'
require 'pry'

class KidsChecker
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def correct_data?
    check_number && not_find_user
  end

  def self.registered(id)
    Gest[id]
  end

  def find_user
    Gest.all.any? { |gest| gest.number.include?(number) }
  end

  def not_find_user
    !find_user
  end

  def check_number
    @check_number ||= YAML.load_file('kids.yaml')['Kids'].include?(number)
  end
end
