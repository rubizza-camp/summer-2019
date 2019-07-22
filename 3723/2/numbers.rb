require 'yaml'

class Numbers
  def self.valid_number?(number)
    YAML.load_file('students.yml')['students'].any?(number)
  end
end
