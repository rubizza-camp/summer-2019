require 'yaml'

class GemfileLoader
  attr_reader :gemfile_path

  def initialize(gemfile_path)
    @gemfile_path = gemfile_path
  end

  def gem_list
    @gem_list ||= YAML.load_file(gemfile_path.to_s)['gems']
  end
end
