require 'yaml'

class Gem_File_Open
	def open_yaml
		@mass = []
		@GEMS = YAML.load_file('gems_list.yaml')
		@mass << @GEMS['gems'].split(' ')		
	end

	def convert_in_new_mass
		@watt = []
		open_yaml
		@watt = @mass.flatten				
	end


	def injek(number)
		convert_in_new_mass
	    @watt[number].scan(/[a-z]+/).join('-')
	end

	def kxm
		convert_in_new_mass
		@watt.size		
	end
end