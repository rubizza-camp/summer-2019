require 'yaml'

# File interaction
class Files
  def name_gem(file = 'gems.yml')
    YAML.load_file(file)['gems']
  rescue Errno::ENOENT
    puts "'#{file}': The file is missing or has an incorrect name."
    exit
  rescue Psych::SyntaxError
    puts "'#{file}': YAML parsing error."\
         'There may be a problem with the contents of the file.'
    exit
  end
end
