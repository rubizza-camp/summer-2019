require 'open-uri'
require 'httparty'

AUTH_TOKEN = YAML.load_file('tokens.yml')['AUTH_TOKEN']

class GithubAPI
  attr_reader :gem_name
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def find_repo
    url = "https://#{AUTH_TOKEN}@api.github.com/search/repositories?q=#{gem_name}&per_page=1"
    HTTParty.get(url).parsed_response['items'][0]['html_url'].to_s
  end
end
