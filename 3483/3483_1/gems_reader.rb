 require 'yaml'

class Gem_File_Open
	def open_yaml
		@mass = []
		@GEMS = YAML.load_file('test.yaml')
		@mass << @GEMS['gems'].split(' ')		
	end

	def convert_in_new_mass
		@watt = []
		open_yaml
		@watt = @mass.flatten				
	end


	def injek(number)
		convert_in_new_mass
		q = @watt[number].scan(/[a-z]+/).join('/')
	end
end


a = Gem_File_Open.new
 puts a.injek(2)