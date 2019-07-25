require 'yaml'
require_relative '../model/user_class'

# class that check user
class UserHelper
  FILE_PATH = 'data/stud.yml'.freeze
  LIST_KEY = 'numbers'.freeze

  def self.existed_numbers(entered_number)
    @existed_numbers ||= YAML.load_file(FILE_PATH).fetch(LIST_KEY, [])
                             .include?(entered_number.to_i)
  end
end
