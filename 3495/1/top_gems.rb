require 'gems'
require 'yaml'
require 'nokogiri'

def ggWp
  yaml_data = YAML.load_file('gem_list.yml')
  gems_arr = yaml_data.values[0]
  gems_arr.each do |gem_for_search|
    gem_url = Gems.info(gem_for_search).values_at('source_code_uri').to_s.delete('", \, [, ]').chomp('/issues')
    if (gem_url == 'nil') or !(gem_url.include? 'https://github.com/') and !(gem_url.include? 'http://github.com/')
      gem_url = Gems.info(gem_for_search).values_at('homepage_uri').to_s.delete('", \, [, ]').chomp('/issues')
    end
    if (gem_url == 'nil') or !(gem_url.include? 'https://github.com/') and !(gem_url.include? 'http://github.com/')
      gem_url = Gems.info(gem_for_search).values_at('bug_tracker_uri').to_s.delete('", \, [, ]').chomp('/issues')
    end
    user = gem_url.split('/', 4).last.split('/').first
    repo = gem_url.split('/').last
  end
end
