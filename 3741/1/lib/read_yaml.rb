require 'yaml'

# read file and back array names of gem
class ReadYaml
  def self.call(file_name, option_name)
    gems = YAML.safe_load(File.open(file_name))['gems']
    option_name ? gems.select { |gem| gem.include? option_name } : gems
  end
end
