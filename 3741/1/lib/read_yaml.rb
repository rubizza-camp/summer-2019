require 'yaml'

# read file and back array names of gem
class ReadYaml
  def self.call(file_name, option_name = nil)
    gems = YAML.safe_load(File.open(file_name))['gems']
    gems.select! { |gem| gem.include? option_name } if option_name
    gems
  end
end
