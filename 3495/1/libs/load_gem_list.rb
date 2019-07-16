# This class load gem list from .yml

class GemListLoader
  attr_reader :gems_arr

  def call(path = 'gem_list.yml')
    @gems_arr = YAML.load_file(path).values[0]
  end

  # def self.call(path = 'gem_list.yml')
  #   new.call(path = 'gem_list.yml')
  # end
end
