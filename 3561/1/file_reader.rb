require 'yaml'
require 'io/console'

class FileReader
  def self.read_yaml(yaml_file)
    YAML.load_file(yaml_file)
  end

  def self.read_txt(txt_file)
    IO.read(txt_file)
  end
end
