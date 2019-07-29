require 'yaml'

PATH_FILE = 'data/students.yml'.freeze

# File interaction
class StudentListFetcher
  def self.read_from_file
    YAML.load_file(PATH_FILE)['sudents']
  rescue Errno::ENOENT
    puts "'#{PATH_FILE}': The file is missing or has an incorrect name."
    exit
  rescue Psych::SyntaxError
    puts "'#{PATH_FILE}': YAML parsing error."\
         'There may be a problem with the contents of the file.'
    exit
  end
end
