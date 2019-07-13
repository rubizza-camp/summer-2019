require 'gems'
require 'yaml'
require 'github_api'

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
    puts gem_url
    user = gem_url.split('/', 4).last.split('/').first
    puts user
    repo = gem_url.split('/').last
    puts repo
    github = Github::new.repos.get user, repo
    puts github['subscribers_count']
    puts github['stargazers_count']
    puts github['forks']
  end
end