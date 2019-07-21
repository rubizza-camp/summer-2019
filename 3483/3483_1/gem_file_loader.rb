require 'yaml'

class GemfileLoader
  attr_reader :gemfile_path

  def initialize(gemfile_path)
    @gemfile_path = gemfile_path
  end

  def gem_list
    @gem_list ||= YAML.load_file(gemfile_path.to_s)['gems']
  end

  def gem_list_range(col)
    @gem_list_range ||=
      YAML.load_file(gemfile_path.to_s)['gems'][0...col]
  end

  def gem_list_text(text)
    @gem_list_text ||=
      YAML.load_file(gemfile_path.to_s)['gems'].select { |gem_| gem_.include?(text) }
  end
end
