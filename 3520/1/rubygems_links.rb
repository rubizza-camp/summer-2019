require 'yaml'

class RubyGemsLink
  def initialize
    @file = './gems.yml'
    @link = 'https://rubygems.org/gems/'
  end

  def yaml_links
    text = File.read @file
    # return YAML.load text
    yaml = YAML.safe_load text
    yaml['gem'].map { |link| @link + link }
  end
end