# This class parse .yml file to hash

require 'yaml'

class YmlParser
  attr_reader :gems_hash

  def parse_yml(yml_file)
    @gems_hash = YAML.load_file(yml_file)
    @gems_hash[:gems] ||= gems_hash.delete('gems')
    gems_hash
  end
end
