require 'yaml'

class YamlParser
  def initialize(yaml_file)
    @yaml_file = yaml_file
  end

  def parse
    YAML.load_file(@yaml_file)['gems']
  end
end
