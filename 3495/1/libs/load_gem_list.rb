# This class load gem list drom .yml
class GemListLoader
  attr_reader :gems_arr
  def initialize(path = 'gem_list.yml')
    @gems_arr = YAML.load_file(path).values[0]
  end
end
