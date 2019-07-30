require 'yaml'
require_relative '../registration/student'

class Checker
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def correct_data?
    check_number && user_not_exists?
  end

  private

  def user_exists?
    Student.find { |student| student.number.include?(number) }
  end

  def user_not_exists?
    !user_exists?
  end

  def check_number
    @check_number ||= YAML.load_file('humans.yaml').include?(number)
  end
end
