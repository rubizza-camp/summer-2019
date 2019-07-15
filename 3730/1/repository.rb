require 'rest-client'
require 'json'

class Repository
  def self.a_gem?(name)
    url = "https://rubygems.org/api/v1/gems/#{name}.json"
    RestClient.get(url)
    true
  rescue RestClient::NotFound
    puts "No such gem #{name}"
    false
  end

  def self.find_github_url(name)
    url = "https://api.github.com/search/repositories?q=#{name}&per_page=1"
    response = RestClient.get(url)
    JSON.parse(response)['items'][0]['html_url']
  end
end
