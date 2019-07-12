# This class parse .yml file to hash

require 'yaml'

class YmlParser
  attr_reader :gems_hash, :yml_file

  def initialize(yml_file)
    parse_yml(yml_file)
  end

  protected

  def parse_yml(yml_file)
    @gems_hash = YAML.load_file(yml_file)
    @gems_hash[:gems] = gems_hash.delete('gems')
  end
end

# gems_hash = YmlParser.new('gems.yml').gems_hash
# p gems_hash
