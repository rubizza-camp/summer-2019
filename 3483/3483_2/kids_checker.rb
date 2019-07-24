require 'yaml'
require_relative 'gest'


class KidsChecker
	attr_reader :number

	def initialize(number)
	  @number = number	
	end

	def correct_data?
	  check_number && find_user
	end

	def self.registered(id)
      Gest[id]
    end

    private

    def find_user
      Gest.all.number.include?(number) == false
    end

	def check_number
	  @check ||= YAML.load_file('kids.yaml')['Kids'].include?(number)	
	end
end

