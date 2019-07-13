require 'gems'
require 'yaml'
require 'graphql'
gem 'github_api-v4-client'

def get_url
  # yaml_data = YAML.load_file('gem_list.yml')
  # gems_arr = yaml_data.values[0]
  # gems_arr.each do |gem_for_search|
  #   gem_url = Gems.info(gem_for_search).values_at('source_code_uri').to_s.delete('", \, [, ]').chomp('/issues')
  #   if (gem_url == 'nil') or !(gem_url.include? 'https://github.com/') and !(gem_url.include? 'http://github.com/')
  #     gem_url = Gems.info(gem_for_search).values_at('homepage_uri').to_s.delete('", \, [, ]').chomp('/issues')
  #   end
  #   if (gem_url == 'nil') or !(gem_url.include? 'https://github.com/') and !(gem_url.include? 'http://github.com/')
  #     gem_url = Gems.info(gem_for_search).values_at('bug_tracker_uri').to_s.delete('", \, [, ]').chomp('/issues')
  #   end
  #   puts gem_url
  # end
  user = Github::User.find('rails')
end
# network/dependents
subscribers_count
stargazers_count
forks



















.