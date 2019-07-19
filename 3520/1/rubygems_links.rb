require 'yaml'

class RubyGemsLink
  def initialize
    @file = './yaml/gems.yml'
    @link = 'https://rubygems.org/gems/'
  end

  def yaml_load
    YAML.safe_load File.read @file
  end

  def yaml_links
    yaml_load['gem'].map { |link| @link + link }
  end

  def gems_name
    yaml_load['gem'].map { |link| link }
  end
end
