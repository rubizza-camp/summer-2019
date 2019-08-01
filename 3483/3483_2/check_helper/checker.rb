require 'yaml'
require_relative '../registration/student'

class Checker
  attr_reader :number

  STUDENT_LIST = 'humans.yaml'.freeze

  def initialize(number)
    @number = number
  end

  def correct_data?
    check_number && user_not_exists?
  end

  private

  def user_exists?
    Student.find(number: number).any?
  end

  def user_not_exists?
    !user_exists?
  end

  def check_number
    @check_number ||= YAML.load_file(STUDENT_LIST).include?(number)
  end
end
