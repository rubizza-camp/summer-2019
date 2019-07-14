require 'yaml'
#:reek:InstanceVariableAssumption xa
class GemFileOpen
  def open_yaml
    @mass = []
    @gems = YAML.load_file('gems_list.yaml')
    @mass << @gems['gems'].split(' ')
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
