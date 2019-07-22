require 'yaml'
require 'io/console'

class FileManager
  def self.read_yaml(file)
    YAML.load_file(file)
  end

  def self.read_txt(file)
    IO.read(file)
  end

  def self.write_txt(file, information)
    IO.write(file, information)
  end
end
