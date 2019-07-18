require './lib/url_checker.rb'
require './lib/data_fetcher.rb'
require 'yaml'
# Class for github links collecting
class GithubLinksCollector
  attr_reader :gems_list, :list_of_urls

  def initialize(file_with_gems)
    @gems_list = YAML.load_file(file_with_gems)
    @list_of_urls = []
    take_github_url
  end

  private

  def take_github_url
    gems_list['gems'].each do |gem_name|
      info = Gems.info gem_name
      checked_url = UrlChecker.new(info['homepage_uri'],
                                   info['source_code_uri'],
                                   info['bug_tracker_uri']).check_url
      list_of_urls << [gem_name, checked_url]
    end
    DataFetcher.new(list_of_urls).collect_all_data
  end
end
