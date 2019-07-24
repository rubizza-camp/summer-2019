require 'yaml'

class Kids
	def self.check(number)
		@check ||= YAML.load_file('kids.yaml')['Kids'].include?(number)	
	end
end
