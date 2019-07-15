require 'yaml'

class FileReader
  def call(from_file)
    read_file(from_file)
  end

  private

  def read_file(from_file)
    if from_file[:gem_name]
      gem_names = YAML.load_file(from_file[:file_name])['gems']
      gem_names.select! { |gem| gem.include?(from_file[:gem_name]) }
    else
      YAML.load_file(FILE_NAME)['gems']
    end
  end
end
