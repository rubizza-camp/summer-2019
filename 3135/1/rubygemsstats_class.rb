require 'net/http'
require 'JSON'

# RubyGemsStats fetches data from rubygems.org by api
# :reek:UtilityFunction:
class RubyGemsStats
  def self.call(gem_name)
    new(gem_name).call
  end

  def call
    data = call_rubygems_api
    {
      github_uri: github_link(data),
      downloads: data['downloads']
    }
  end

  private

  def initialize(name)
    @name = name
  end

  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    JSON.parse(Net::HTTP.get(URI(uri)))
  end

  def github_link(data)
    [data['source_code_uri'], data['homepage_uri']]
      .find { |link| link.to_s.include? 'github.com' }
  end
end
