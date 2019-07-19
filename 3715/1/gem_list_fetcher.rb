require 'yaml'

DEFAULT_FILE = 'gems.yml'.freeze

# File interaction
class GemListFetcher
  def read_from_file(file = DEFAULT_FILE)
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
