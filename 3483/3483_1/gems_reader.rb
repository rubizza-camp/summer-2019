require 'yaml'
#:reek:InstanceVariableAssumption
class GemFileListOpen
  def inject(number)
    open_yaml
    @array[number].scan(/[a-z]+/).join('-')
  end

  def yaml_size
    open_yaml
    @array.size
  end

  private

  def open_yaml
    @array = []
    gems = YAML.load_file('gems_list.yaml')
    @array << gems['gems'].split(' ')
    @array.flatten!
  end
end
