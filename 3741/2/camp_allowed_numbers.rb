# frozen_string_literal: true

require 'yaml'

class CampAllowedNumbers
  def self.include_number_in_list?(number)
    list_of_numbers ||= YAML.load_file('./lib/camp_allowed_numbers.yml')['camp_numbers']
    list_of_numbers.include?(number)
  end
end
