require 'yaml'

class GithubLinksLoader
  def initialize
    @gems_data = []
    @params = ARGV.empty? ? [] : ARGV.first.split('=')
    @source = ''
  end

  DEFAULT_FILE = 'gems.yml'.freeze

  def yml_gems
    yml_gem_list = take_gem_list

    yml_gem_list['gems'].each do |gem_name|
      gem_info = Gems.info(gem_name)

      @gems_data << {
        gem_name: gem_name,
        source: source_set(gem_info)
      }
    end
    @gems_data
  end

  def take_gem_list
    return YAML.load_file(@params[1]) if @params[0] == '--file'

    YAML.load_file(DEFAULT_FILE)
  end

  def source_set(info)
    @source = info['source_code_uri']

    return info['homepage_uri'] unless @source

    @source
  end
end
