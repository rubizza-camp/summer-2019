require_relative 'client.rb'
require_relative 'path_gem_directory.rb'
require_relative 'gem_parameters.rb'

class Scraper
  def self.fetch_gem_parameters(gems_names)
    fetcher = new(gems_names)
    fetcher.all_gems_info(gems_names)
  end

  attr_reader :all_gems

  def initialize(gems_names)
    @gems_names = gems_names
    @gem_parameters = nil
  end

  def all_gems_info(gems_names)
    @all_gems = gems_names.map do |name_gem|
      if check_gem(name_gem)
        GemResource.new(name_gem, @gem_parameters)
      else
        puts('github.com has no gem: ' + name_gem)
      end
    end
    all_gems.compact!
  end

  private

  def client
    @client ||= Client.initialize_client
  end

  def gem_path_directory(name_gem)
    PathGemDirectory.fetch_gem_path_directory(name_gem)
  end

  def check_gem(name_gem)
    return nil unless gem_path_directory(name_gem)
    fetch_gem_paraeters(name_gem)
  end

  def fetch_gem_paraeters(name_gem)
    path = gem_path_directory(name_gem)
    repository = client.repo(path)
    @gem_parameters = GemParameters.fetch_gem_parameters(repository, path)
  end
end
