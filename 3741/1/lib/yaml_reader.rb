require 'yaml'

# read file and back array names of gem
class YamlReader
  def self.read(file_name, option_name)
    yaml_reader = YamlReader.new
    yaml_reader.read(file_name, option_name)
    yaml_reader.gems
  end

  attr_reader :gems

  def read(file_name, option_name)
    gems = YAML.safe_load(File.open(file_name))['gems']
    @gems = option_name ? gems.select! { |gem| gem.include? option_name } : gems
  end
end
