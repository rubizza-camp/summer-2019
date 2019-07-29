# frozen_string_literal: true

require 'yaml'

# Here we scan .yml file with students' ID
module YamlScanner
  def students_id
    YAML.load_file('data/student_id.yml')['id']
  rescue Errno::ENOENT => err
    abort(err.message)
  end
end
