require 'yaml'
require_relative 'gest'


class Kids
	def self.registered(id)
      Gest[id]
    end

    def self.find_user(number)
      Gest.all.number.include?(number)
    end

	def check_number(number)
		@check ||= YAML.load_file('kids.yaml')['Kids'].include?(number)	
	end
end
