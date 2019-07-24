require 'yaml'

class Kids
	def 
		@check ||= YAML.load_file('kids.yaml')['Kids'].include?(number)	
	end
end
