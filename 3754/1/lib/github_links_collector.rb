require './lib/url_checker.rb'
require 'yaml'
# Class for github links collecting
class GithubLinksCollector
  attr_reader :urls_list

  def initialize
    @urls_list = {}
  end

  def self.take_urls(gems_list)
    new.take_urls(gems_list)
  end

  def take_urls(gems_list)
    YAML.load_file(gems_list)['gems'].each do |gem_name|
      checked_url = UrlChecker.new((Gems.info gem_name)['homepage_uri'],
                                   (Gems.info gem_name)['source_code_uri'],
                                   (Gems.info gem_name)['bug_tracker_uri']).check_url
      urls_list[gem_name] = checked_url
    end
    urls_list
  end
end
