require_relative 'client.rb'
require_relative 'path_gem_directory.rb'
require_relative 'gem_parameters.rb'
require_relative 'gem_resource.rb'

class Scraper
  def self.fetch_gem_parameters(gems_names)
    fetcher = new(gems_names)
    fetcher.all_gems_info(gems_names)
  end

  attr_reader :all_gems

  def initialize(gems_names)
    @gems_names = gems_names
    @client = Client.initialize_client
  end

  def all_gems_info(gems_names)
    all_gems = gems_names.map do |gem_name|
      if validate_gem(gem_name)
        GemResource.new(gem_name, fetch_gem_paraeters(gem_name))
      else
        puts('github.com has no gem: ' + gem_name)
      end
    end
    all_gems.compact!
  end

  private

  def gem_path_directory(gem_name)
    PathGemDirectory.fetch_gem_path_directory(gem_name)
  end

  def validate_gem(gem_name)
    return nil unless gem_path_directory(gem_name)
    true
  end

  def fetch_gem_paraeters(gem_name)
    path = gem_path_directory(gem_name)
    repository = @client.repo(path)
    GemParameters.fetch_gem_parameters(repository, path)
  end
end
